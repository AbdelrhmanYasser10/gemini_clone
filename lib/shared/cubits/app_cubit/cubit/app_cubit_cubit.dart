import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_iq/index.dart';
import 'package:chat_iq/models/chat_model.dart';
import 'package:chat_iq/models/message_model.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'app_cubit_state.dart';

class AppCubitCubit extends Cubit<AppCubitState> {
  AppCubitCubit() : super(AppCubitInitial());
  static AppCubitCubit get(context) => BlocProvider.of(context);
  int currentChatId = 0;
  final _auth = FirebaseAuth.instance;
  final _database = FirebaseFirestore.instance;

  List<ChatModel> historyChats = [];

  XFile? pickedImage;
  CroppedFile? finalImage;
  final cloudinary = Cloudinary.signedConfig(
    apiKey: "Your Api key" ,
    apiSecret: "Your secert key",
    cloudName: "Your cloud name",
  );

  void getImageFromGallery() async {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      emit(GetImageSuccessfully());
    } else {
      emit(GetImageError());
    }
  }

  void cropImage() async {
    finalImage = await ImageCropper().cropImage(
      sourcePath: pickedImage!.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
      ],
    );

    emit(CropImageSuccessfully());
  }

  void removeImageFromMemory() {
    pickedImage = finalImage = null;
    emit(RemoveImageFromMemory());
  }

  void sendUserMessage({required String message}) {
    //Send Text to Gemini
    if (finalImage == null) {
      MessageModel messageModel = MessageModel(
        content: message,
        time: Timestamp.now(),
        is_sender: false,
        media: null,
      );
      _database
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection("chats")
          .doc(currentChatId.toString())
          .collection("messages")
          .add(messageModel.toMap())
          .then((value) {
        _database
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .collection("chats")
            .doc(currentChatId.toString())
            .set({
          'time': Timestamp.now(),
          'lastMessage': messageModel.content,
        });
        emit(SendMessageSuccessfully());

        getGeminiResponse(prom: message).then((value) {
          messageModel = MessageModel(
              content: value!,
              time: Timestamp.now(),
              is_sender: true,
              media: null);
          _database
              .collection("users")
              .doc(_auth.currentUser!.uid)
              .collection("chats")
              .doc(currentChatId.toString())
              .collection("messages")
              .add(messageModel.toMap())
              .then((v) {
            _database
                .collection("users")
                .doc(_auth.currentUser!.uid)
                .collection("chats")
                .doc(currentChatId.toString())
                .set({
              'time': Timestamp.now(),
              'lastMessage': messageModel.content,
            });
            emit(SendMessageSuccessfully());
          }).catchError((error) {
            emit(SendMessageWithError());
          });
        }).catchError((error) {
          emit(SendMessageWithError());
        });
      }).catchError((error) {
        emit(SendMessageWithError());
      });
    } else {
      emit(UserUploadImageLoading());
      cloudinary
          .upload(
              file: finalImage!.path,
              fileBytes: File(finalImage!.path).readAsBytesSync(),
              resourceType: CloudinaryResourceType.image,
              folder: "Gemini-Data",
              fileName: finalImage!.path.split("/").last, //filname.png
              progressCallback: (count, total) {})
          .then((value) {
        if (value.isSuccessful) {
          MessageModel messageModel = MessageModel(
            content: message,
            time: Timestamp.now(),
            is_sender: false,
            media: value.url,
          );
          _database
              .collection("users")
              .doc(_auth.currentUser!.uid)
              .collection("chats")
              .doc(currentChatId.toString())
              .collection("messages")
              .add(messageModel.toMap())
              .then((value) {
            _database
                .collection("users")
                .doc(_auth.currentUser!.uid)
                .collection("chats")
                .doc(currentChatId.toString())
                .set({
              'time': Timestamp.now(),
              'lastMessage': messageModel.content,
            });
            getGeminiResponse(prom: message).then((value) {
              finalImage = pickedImage = null;
              messageModel = MessageModel(
                content: value!,
                time: Timestamp.now(),
                is_sender: true,
                media: null,
              );
              _database
                  .collection("users")
                  .doc(_auth.currentUser!.uid)
                  .collection("chats")
                  .doc(currentChatId.toString())
                  .collection("messages")
                  .add(messageModel.toMap())
                  .then((v) {
                _database
                    .collection("users")
                    .doc(_auth.currentUser!.uid)
                    .collection("chats")
                    .doc(currentChatId.toString())
                    .set({
                  'time': Timestamp.now(),
                  'lastMessage': messageModel.content,
                });
                emit(SendMessageSuccessfully());
              }).catchError((error) {
                emit(SendMessageWithError());
              });
            }).catchError((error) {
              emit(SendMessageWithError());
            });
          });
        } else {
          emit(SendMessageWithError());
        }
      }).catchError((error) {
        emit(SendMessageWithError());
      });
    }
  }

  Future<String?> getGeminiResponse({required String prom}) async {
    emit(GetResponseFromGeminiLoading());
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: "API KEY",
    );

    if (finalImage == null) {
      final content = [Content.text(prom)];
      final response = await model.generateContent(content);
      return response.text;
    } else {
      final prompt = TextPart(prom);
      final imageParts = [
        DataPart('image/jpeg', await finalImage!.readAsBytes()),
      ];
      final response = await model.generateContent([
        Content.multi([prompt, ...imageParts])
      ]);
      return response.text;
    }
  }

  List<MessageModel> allMessages = [];
  void getAllMessage() {
    String myId = _auth.currentUser!.uid;
    emit(GetAllMessagesLoading());
    _database
        .collection("users")
        .doc(myId)
        .collection("chats")
        .doc(currentChatId.toString())
        .collection("messages")
        .orderBy("time")
        .snapshots()
        .listen((event) {
      allMessages = [];
      for (var element in event.docs) {
        print(element.data());
        allMessages.add(MessageModel.fromJson(element.data()));
      }
      emit(GetAllMessagesSuccessfully());
    });
  }

  void getAllChats() {
    String myId = _auth.currentUser!.uid;
    emit(GetAllChatsLoading());
    _database
        .collection("users")
        .doc(myId)
        .collection("chats")
        .orderBy("time")
        .snapshots()
        .listen((event) {
      historyChats = [];
      for (var element in event.docs) {
        ChatModel chatModel = ChatModel(id: element.id);
        chatModel.lastMessage = element.data()["lastMessage"];
        chatModel.timestamp = element.data()["time"];
        historyChats.add(chatModel);
      }
      emit(GetAllChatsSuccessfully());
    });
  }
}

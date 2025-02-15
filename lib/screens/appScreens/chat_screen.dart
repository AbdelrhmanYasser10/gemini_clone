import 'dart:io';

import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_iq/index.dart';
import 'package:chat_iq/models/message_model.dart';
import 'package:chat_iq/shared/cubits/app_cubit/cubit/app_cubit_cubit.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({
    super.key,
  });

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  String _fullWord = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    _controller.text = _fullWord;
    _fullWord = _lastWords = '';
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      _fullWord += ' $_lastWords';
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubitCubit.get(context).getAllMessage();
        return BlocConsumer<AppCubitCubit, AppCubitState>(
          listener: (context, state) {
            if (state is GetImageSuccessfully) {
              AppCubitCubit.get(context).cropImage();
            }
          },
          builder: (context, state) {
            var cubit = AppCubitCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    CircleAvatar(
                        // backgroundImage: NetworkImage(
                        //   widget.reciverUser.imageLink,
                        // ),
                        ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'ChatIQ bot',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        if (index < cubit.allMessages.length) {
                          MessageModel currMessage = cubit.allMessages[index];
                          if (currMessage.media == null) {
                            return BubbleSpecialThree(
                              text: currMessage.content,
                              color: !currMessage.is_sender
                                  ? const Color(0xFF1B97F3)
                                  : const Color(0xFFE8E8EE),
                              tail: false,
                              isSender: !currMessage.is_sender,
                            );
                          } else {
                            return Column(
                              children: [
                                BubbleSpecialThree(
                                  text: currMessage.content,
                                  color: !currMessage.is_sender
                                      ? const Color(0xFF1B97F3)
                                      : const Color(0xFFE8E8EE),
                                  tail: false,
                                  isSender: !currMessage.is_sender,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => SizedBox(
                                              width: 200,
                                              height: 200,
                                              child: Image.network(
                                                cubit.allMessages[index].media!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Image.network(
                                          cubit.allMessages[index].media!,
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        } else {
                          if (state is GetResponseFromGeminiLoading) {
                            return const BubbleSpecialThree(
                              text: "Loading Gemini Response",
                              color: Color(0xFFE8E8EE),
                              tail: false,
                              isSender: false,
                            );
                          } else if (state is UserUploadImageLoading) {
                            return const BubbleSpecialThree(
                              text: "Waiting until upload your image ...",
                              color: Color(0xFF1B97F3),
                              tail: false,
                              isSender: true,
                            );
                          } else {
                            return const SizedBox();
                          }
                        }
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 10.0.h,
                        );
                      },
                      itemCount: cubit.allMessages.length + 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          cubit.finalImage != null
                              ? GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => SizedBox(
                                        width: 200,
                                        height: 200,
                                        child: Image.file(
                                          File(cubit.finalImage!.path),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        height: 55,
                                        width: double.infinity,
                                        child: Image.file(
                                          File(cubit.finalImage!.path),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        right: 2,
                                        top: 2,
                                        child: GestureDetector(
                                          onTap: () {
                                            cubit.removeImageFromMemory();
                                          },
                                          child: const CircleAvatar(
                                            radius: 10,
                                            backgroundColor: Colors.white,
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.red,
                                              size: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _controller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Message cannot be empty";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {

                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Enter yout message ....",
                                    filled: true,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.attachment,
                                      ),
                                      onPressed: () {
                                        print("Clicked");
                                        AppCubitCubit.get(context)
                                            .getImageFromGallery();
                                      },
                                    ),
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              _controller.text == ""
                                  ? GestureDetector(
                                      onLongPress: () {
                                        print(_speechEnabled);
                                        if (_speechEnabled) {
                                          _startListening();
                                        }
                                      },
                                      onLongPressEnd: (details) {
                                        print("End recording");
                                        if (_speechEnabled) {
                                          _stopListening();
                                        }
                                      },
                                      child: CircleAvatar(
                                        radius: _speechEnabled ? 24 : 20,
                                        backgroundColor: Colors.blue,
                                        child: Icon(
                                          Icons.mic,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : FloatingActionButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          cubit.sendUserMessage(
                                            message: _controller.text,
                                          );
                                          _controller.clear();
                                        }
                                      },
                                      backgroundColor: Colors.blue,
                                      child: const Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

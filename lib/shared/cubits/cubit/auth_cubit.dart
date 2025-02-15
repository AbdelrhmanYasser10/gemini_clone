import 'package:chat_iq/index.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  late String email;
  late String username;

  UserModel? userModel;

  void register({

    required String password,
  }) {
    emit(RegisterLoading());

    _auth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      // Create a user model with default values
      UserModel user = UserModel(
        email: email,
        username: username,
        userId: value.user!.uid,
        // Add other fields as needed, e.g., default profile picture URL if applicable
      );
      _database
          .collection("users")
          .doc(value.user!.uid)
          .set(user.toMap())
          .then((_) {
        emit(RegisterSuccess());
      }).catchError((error) {
        print("Error saving user to database: $error");
        emit(RegisterError());
      });
    }).catchError((error) {
      print("Error during registration: $error");
      emit(RegisterError());
    });
  }

  void login({required String email, required String password}) {
    emit(LoginLoading());

    _auth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      _database.collection("users").doc(value.user!.uid).get().then((element) {
        userModel = UserModel.fromJson(element.data()!);
        emit(LoginSuccess());
      }).catchError((error) {
        print("Error fetching user data: $error");
        emit(LoginError());
      });
    }).catchError((error) {
      print("Error during login: $error");
      emit(LoginError());
    });
  }
}

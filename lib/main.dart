import 'package:chat_iq/index.dart';
import 'package:chat_iq/screens/appScreens/home_screen.dart';
import 'package:chat_iq/shared/cubits/app_cubit/cubit/app_cubit_cubit.dart';
import 'package:chat_iq/shared/cubits/cubit/auth_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
      create: (context) => AuthCubit(),
      ),
      BlocProvider(
      create: (context) => AppCubitCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) {
          return MaterialApp(
            home: FirebaseAuth.instance.currentUser != null ? ChatBotHomeScreen():SignInPage(),
          );
        },
      ),
    );
  }
}

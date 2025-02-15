import 'package:chat_iq/index.dart';
import 'package:chat_iq/shared/cubits/cubit/auth_cubit.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16),
              child: SvgPicture.asset('assets/Svgs/signup.svg'),
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              'Create account',
              style: Constants.twentyfoursmbold,
            ),
            SizedBox(
              height: 32.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 51.w),
              child: Container(
                height: 53.h,
                width: 297.w,
                child: const Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    BuildTimeLinetile(
                      isSelected: false,
                      text: 'Email',
                    ),
                    BuildTimeLinetile(
                      isSelected: false,
                      text: 'Name',
                    ),
                    BuildTimeLinetile(
                      isSelected: false,
                      text: 'Birthday',
                    ),
                    BuildTimeLinetile(
                      isSelected: false,
                      text: 'Gender',
                    ),
                    BuildTimeLinetile(
                      text: 'Pass',
                      isSelected: false,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 45.h,
            ),
            Form(
              key: _formKey,
              child: CustomTextField(
                title: 'Email',
                controller: _emailController,
                hintText: 'Johndoe@exemple.com',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  RegExp regExp = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                  if (value == null || value.isEmpty) {
                    return "Email cannot be empty";
                  } else {
                    if (!regExp.hasMatch(value)) {
                      return "Enter an invalid email";
                    }
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 31.h,
            ),
            CustomElevatedButton(
                buttonName: 'Continue',
                onTab: () {
                  if (_formKey.currentState!.validate()) {
                    AuthCubit.get(context).email = _emailController.text;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FullNamePage()));
                  }
                }),
            SizedBox(
              height: 32.h,
            ),
            // AuthFuncs(title: 'Sign up with'),
            // SizedBox(
            //   height: 12.h,
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 51.w),
              child: Divider(),
            ),
            Bottombar(
              text: 'Have an account?',
              onTab: () {},
              auth: 'Login',
              builder: (BuildContext context) => SignInPage(),
            )
          ],
        ),
      ),
    );
  }
}

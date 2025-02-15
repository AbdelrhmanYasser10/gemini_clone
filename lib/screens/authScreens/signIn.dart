import 'dart:developer';

import 'package:chat_iq/index.dart';

class SignInPage extends StatefulWidget {
  SignInPage({
    super.key,
  });
  static const routeName = 'SignIn';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: SvgPicture.asset('assets/Svgs/signin.svg'),
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                'Log In',
                style: Constants.twentyfoursmbold,
              ),
              SizedBox(
                height: 32.h,
              ),
              CustomTextField(
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                },
                onChanged: (value) {
                  setState(() {
                    log('dfdfdf');
                  });
                },
                title: 'Email',
                hintText: 'Johndoe@exemple.com',
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your Password';
                  }
                  if (value.length < 5) {
                    return 'Please enter a Strong password';
                  }
                },
                title: 'Password',
                hintText: '*************',
                keyboardType: TextInputType.text,
                obsecureText: true,
              ),
              SizedBox(
                height: 32.h,
              ),
              CustomElevatedButton(
                buttonName: 'Log In',
                onTab: () {
                  if (formKey.currentState!.validate()) {
                    print('object');
                  }
                },
              ),
              SizedBox(
                height: 32.h,
              ),
              // AuthFuncs(
              //   title: 'Log in with',
              // ),
              SizedBox(
                height: 12.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 51.w),
                child: const Divider(),
              ),
              Bottombar(
                auth: 'Sign Up',
                text: 'No account ?',
                onTab: () {},
                builder: (BuildContext context) => const SignUp(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

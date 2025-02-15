import 'package:chat_iq/screens/authScreens/DateOfBirthPage.dart';
import 'package:chat_iq/screens/authScreens/signIn.dart';
import 'package:chat_iq/shared/cubits/cubit/auth_cubit.dart';
import 'package:chat_iq/shared/widgets/authWidgets/customSignUp.dart';
import 'package:chat_iq/shared/widgets/authWidgets/custom_authfunc.dart';
import 'package:chat_iq/shared/widgets/authWidgets/custom_bottombar.dart';
import 'package:chat_iq/shared/widgets/authWidgets/custom_elevated_button.dart';
import 'package:chat_iq/shared/widgets/authWidgets/custom_textfield.dart';
import 'package:chat_iq/shared/widgets/authWidgets/custom_timelinelisttile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FullNamePage extends StatefulWidget {
  const FullNamePage({super.key});

  @override
  State<FullNamePage> createState() => _FullNamePageState();
}

class _FullNamePageState extends State<FullNamePage> {
  final TextEditingController _userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          CustomSignUp(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 51.w),
            child: Container(
              height: 53.h,
              width: 297.w,
              child: const Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  BuildTimeLinetile(
                    isSelected: true,
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "User name cannot be empty";
                } else {
                  return null;
                }
              },
              title: 'Your Full Name',
              hintText: 'John doe',
              keyboardType: TextInputType.name,
            ),
          ),
          SizedBox(
            height: 31.h,
          ),
          CustomElevatedButton(
              buttonName: 'Continue',
              onTab: () {
                if (_formKey.currentState!.validate()) {
                  AuthCubit.get(context).username = _userNameController.text;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DateOfBirth()));
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
        ]),
      ),
    );
  }
}

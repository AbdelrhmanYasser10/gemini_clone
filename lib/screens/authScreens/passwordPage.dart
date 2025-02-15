import 'package:chat_iq/screens/authScreens/otpPage.dart';
import 'package:chat_iq/shared/cubits/cubit/auth_cubit.dart';
import 'package:chat_iq/shared/widgets/authWidgets/customSignUp.dart';
import 'package:chat_iq/shared/widgets/authWidgets/custom_elevated_button.dart';
import 'package:chat_iq/shared/widgets/authWidgets/custom_textfield.dart';
import 'package:chat_iq/shared/widgets/authWidgets/custom_timelinelisttile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Password extends StatefulWidget {
  const Password({super.key});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                      isSelected: true,
                      text: 'Name',
                    ),
                    BuildTimeLinetile(
                      isSelected: true,
                      text: 'Birthday',
                    ),
                    BuildTimeLinetile(
                      isSelected: true,
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
              child: Column(
                children: [
                  CustomTextField(
                    controller: _passwordController,
                    title: 'Password',
                    hintText: '',
                    keyboardType: TextInputType.text,
                    obsecureText: true,
                    validator: (value) {
                      RegExp regex = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      } else {
                        if (!regex.hasMatch(value)) {
                          return 'Enter valid password';
                        } else {
                          return null;
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomTextField(
                    title: 'Confirm Password',
                    hintText: '',
                    keyboardType: TextInputType.text,
                    obsecureText: true,
                    validator: (value) {
                      if (value!.isEmpty) return 'Empty';
                      if (value != _passwordController.text) return 'Not Match';
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 26.h,
            ),
            CustomElevatedButton(
                buttonName: 'Finish',
                onTab: () {
                  if (_formKey.currentState!.validate()) {
                    AuthCubit.get(context)
                        .register(password: _passwordController.text);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const OTP()));
                  }
                })
          ],
        ),
      ),
    );
  }
}

import 'package:chat_iq/screens/authScreens/gender.dart';
import 'package:chat_iq/screens/authScreens/signIn.dart';
import 'package:chat_iq/shared/widgets/authWidgets/customSignUp.dart';
import 'package:chat_iq/shared/widgets/authWidgets/custom_authfunc.dart';
import 'package:chat_iq/shared/widgets/authWidgets/custom_bottombar.dart';
import 'package:chat_iq/shared/widgets/authWidgets/custom_elevated_button.dart';
import 'package:chat_iq/shared/widgets/authWidgets/custom_textfield.dart';
import 'package:chat_iq/shared/widgets/authWidgets/custom_timelinelisttile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateOfBirth extends StatelessWidget {
  const DateOfBirth({super.key});

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
            CustomTextField(
              title: 'Date Of Birth',
              hintText: 'DD/MM/YYYY',
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(
              height: 31.h,
            ),
            CustomElevatedButton(
                buttonName: 'Continue',
                onTab: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Gender()));
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

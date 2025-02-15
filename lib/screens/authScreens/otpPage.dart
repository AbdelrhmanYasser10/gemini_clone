import 'package:chat_iq/index.dart';
import 'package:chat_iq/screens/appScreens/home_screen.dart';
import 'package:chat_iq/shared/cubits/cubit/auth_cubit.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OTP extends StatelessWidget {
  const OTP({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: SvgPicture.asset('assets/Svgs/signin.svg'),
            ),
            SizedBox(
              height: 27.h,
            ),
            Text(
              'Enter Confirmation Code',
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
                      isSelected: true,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Text(
              textAlign: TextAlign.center,
              '''Enter the 6-digit code we sent to 
        ${AuthCubit.get(context).email}''',
              style: Constants.sixteenmid,
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  'Resend code',
                  style: Constants.sixteensmbold,
                )),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: OtpTextField(
                numberOfFields: 5,
                fillColor: Colors.grey.shade300,
                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                borderColor: Colors.grey.shade300,
                filled: true,

                borderRadius: BorderRadius.circular(8),
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Verification Code"),
                          content: Text('Code entered is $verificationCode'),
                        );
                      });
                }, // end onSubmit
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
            CustomElevatedButton(
                buttonName: 'Confirm',
                onTab: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatBotHomeScreen()));
                })
          ],
        ),
      ),
    );
  }
}

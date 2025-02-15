import 'package:chat_iq/index.dart';

class Gender extends StatelessWidget {
  const Gender({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 51.w),
            child: Container(
              height: 46.h,
              decoration: BoxDecoration(
                color: Color(0xffD3D3D3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                  ),
                ],
              ),
              child: DropDownTextField(
                textFieldDecoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(16, 12, 16, 14),
                  hintText: 'Select you gender',
                  hintStyle: Constants.hintStyle,
                ),
                dropDownList: const [
                  DropDownValueModel(name: 'male', value: "value1"),
                  DropDownValueModel(
                      name: 'female',
                      value: "value2",
                      toolTipMsg:
                          "DropDownButton is a widget that we can use to select one unique value from a set of values"),
                  DropDownValueModel(
                      name: 'Prefer not to say', value: "value3"),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 31.h,
          ),
          CustomElevatedButton(
              buttonName: 'Continue',
              onTab: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Password()));
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
    );
  }
}

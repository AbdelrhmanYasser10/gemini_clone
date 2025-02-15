import 'package:chat_iq/index.dart';

class CustomSignUp extends StatelessWidget {
  const CustomSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
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
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 32.h),
            child: Container(
              height: 40.h,
              width: 40.w,
              child: InkWell(
                child: SvgPicture.asset(
                  'assets/Svgs/back-svgrepo-com.svg',
                  color: Colors.black,
                  height: 40.h,
                  width: 40.w,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

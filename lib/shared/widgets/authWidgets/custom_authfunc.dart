
import 'package:chat_iq/index.dart';

class AuthFuncs extends StatelessWidget {
  const AuthFuncs({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 75.w),
      child: Container(
        height: 32.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: Constants.eighteenmid,
            ),
            SizedBox(
              width: 8.w,
            ),
            SvgPicture.asset('assets/Svgs/google.svg'),
            SvgPicture.asset('assets/Svgs/logos_facebook.svg'),
            SvgPicture.asset('assets/Svgs/github.svg'),
          ],
        ),
      ),
    );
  }
}

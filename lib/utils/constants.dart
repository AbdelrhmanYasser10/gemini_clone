import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Constants {
  static const mainFonts = GoogleFonts.montserrat;
  static const mainFont = 'Montserrat';
  static const mainColor = Color.fromARGB(255, 0, 0, 0);
  static const orange = Color(0xffF49E00);
  static const grey = Color(0xffD3D3D3);
  static const deepBlue = Color(0xff36454F);

  static var twentyfoursmbold = TextStyle(
    fontFamily: Constants.mainFont,
    color: const Color(0xff36454F),
    fontWeight: FontWeight.bold,
    fontSize: 24.sp,
  );
  static var eighteenmbold = TextStyle(
    fontFamily: Constants.mainFont,
    color: const Color(0xff36454F),
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
  );
  static var eighteenmid = TextStyle(
    fontFamily: Constants.mainFont,
    color: const Color.fromARGB(255, 255, 255, 255),
    fontWeight: FontWeight.w500,
    fontSize: 18.sp,
  );
  static var titleColor = TextStyle(
    fontFamily: Constants.mainFont,
    color: const Color.fromARGB(255, 0, 0, 0),
    fontWeight: FontWeight.w500,
    fontSize: 18.sp,
  );
  static var sixteenmid = TextStyle(
    fontFamily: Constants.mainFont,
    color: const Color(0xff36454F),
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
  );
  static var hintStyle = TextStyle(
    fontFamily: Constants.mainFont,
    color: const Color.fromARGB(41, 19, 23, 27),
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
  );
  static var sixteensmbold = TextStyle(
    fontFamily: Constants.mainFont,
    color: const Color.fromARGB(255, 0, 0, 0),
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
  );
  static var forteensmbold = TextStyle(
    fontFamily: Constants.mainFont,
    color: Constants.mainColor,
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
  );
  static var forteenmid = TextStyle(
    fontFamily: Constants.mainFont,
    color: const Color(0xff36454F),
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
  );
  static var barText = TextStyle(
    fontFamily: Constants.mainFont,
    color: const Color(0xff36454F),
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
  );
  static var containerInput = Container(
    height: 56.h,
    width: 40.w,
    decoration: BoxDecoration(
      color: Constants.grey,
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

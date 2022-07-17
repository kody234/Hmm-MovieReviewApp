import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  TextTheme lightTextTheme = TextTheme(
    headline1: TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: 20.sp,
      color: const Color(0xff110E47),
    ),
    headline2: TextStyle(
        fontWeight: FontWeight.w700, fontSize: 14.sp, color: Colors.black),
    headline3: TextStyle(fontWeight: FontWeight.w900, fontSize: 16.sp),
    headline4: TextStyle(fontWeight: FontWeight.w400, fontSize: 17.sp),
    headline5: TextStyle(
        fontWeight: FontWeight.w700, fontSize: 26.sp, color: Colors.black),
  );

  TextTheme darkTextTheme = const TextTheme(
    headline1: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
    headline2: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
  );

  ThemeData light() {
    return ThemeData(
        brightness: Brightness.light,
        textTheme: lightTextTheme,
        scaffoldBackgroundColor: Colors.white);
  }

  ThemeData dark() {
    return ThemeData(brightness: Brightness.dark, textTheme: darkTextTheme);
  }
}

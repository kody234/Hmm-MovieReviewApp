import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hmm_movie_review_app/screens/home_screen.dart';

import 'app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            theme: AppTheme().light(),
            darkTheme: AppTheme().dark(),
            themeMode: ThemeMode.light,
            home: HomeScreen(),
          );
        });
  }
}

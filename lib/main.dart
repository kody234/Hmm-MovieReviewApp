import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hmm_movie_review_app/screens/category_screen.dart';
import 'package:hmm_movie_review_app/screens/home_screen.dart';
import 'package:hmm_movie_review_app/screens/trailer_screen.dart';
import 'package:hmm_movie_review_app/state_manager/state_manager.dart';
import 'package:provider/provider.dart';

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
          return MultiProvider(
            providers: [ChangeNotifierProvider(create: (_) => StateManager())],
            child: MaterialApp(
              theme: AppTheme().light(),
              darkTheme: AppTheme().dark(),
              themeMode: ThemeMode.light,
              home: HomeScreen(),
            ),
          );
        });
  }
}

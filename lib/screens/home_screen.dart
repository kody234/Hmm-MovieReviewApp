import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/custom_bottom_nav.dart';
import '../components/movie_card.dart';
import '../components/movie_card_detailed.dart';
import '../components/section.dart';
import '../components/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  void onPress(int index) {
    setState(() {});
    selectedIndex = index;
    if (kDebugMode) {
      print(selectedIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    String movieLength = '1h 47m';
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: CustomScrollView(
          slivers: [
            const CustomAppBar(),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return SafeArea(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Section(
                        press: () {},
                        section: 'Now Showing',
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 24.w),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              3,
                              (index) => const MovieCard(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Section(section: 'Popular', press: () {}),
                      SizedBox(
                        height: 12.h,
                      ),
                      MovieCardDetailed(movieLength: movieLength),
                      MovieCardDetailed(movieLength: movieLength),
                      MovieCardDetailed(movieLength: movieLength),
                    ],
                  ),
                ));
              }, childCount: 1),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(),
    );
  }
}

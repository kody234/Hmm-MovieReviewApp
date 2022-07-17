import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hmm_movie_review_app/services/api_service.dart';

import '../components/custom_app_bar.dart';
import '../components/custom_bottom_nav.dart';
import '../components/movie_card.dart';
import '../components/movie_card_detailed.dart';
import '../components/section.dart';
import '../model/movie.dart';
import '../model/product.dart';
import 'movie_details _screen.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    getPopularMovies();
  }

  List<Movie>? popularMovies;
  bool isGotten = false;

  getPopularMovies() async {
    popularMovies = await ApiService().getPopularMovies();
    if (popularMovies != null) {
      setState(() {
        isGotten = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String movieLength = '1h 47m';
    return Scaffold(
      drawer: const Drawer(),
      drawerEnableOpenDragGesture: false,
      body: isGotten
          ? Padding(
              padding: EdgeInsets.only(top: 5.h),
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
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: Section(
                                press: () {},
                                section: 'Now Showing',
                              ),
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
                                    popularMovies!.length,
                                    (index) => InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => MovieDetailScreen(
                                                movie: popularMovies![index]),
                                          ),
                                        );
                                      },
                                      child: MovieCard(
                                        movie: popularMovies![index],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: Section(section: 'Popular', press: () {}),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            Column(
                              children: List.generate(
                                popularMovies!.length,
                                (index) => InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => MovieDetailScreen(
                                            movie: popularMovies![index]),
                                      ),
                                    );
                                  },
                                  child: MovieCardDetailed(
                                    movie: popularMovies![index],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
                    }, childCount: 1),
                  )
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
      bottomNavigationBar: CustomBottomNav(),
    );
  }
}

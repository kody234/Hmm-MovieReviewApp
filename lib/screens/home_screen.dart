import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hmm_movie_review_app/components/shimmer_widget.dart';
import 'package:hmm_movie_review_app/constants.dart';
import 'package:hmm_movie_review_app/screens/bookmark_screen.dart';
import 'package:hmm_movie_review_app/screens/category_screen.dart';
import 'package:hmm_movie_review_app/screens/search_movie_screen.dart';
import 'package:hmm_movie_review_app/services/api_service.dart';
import 'package:provider/provider.dart';

import '../components/custom_app_bar.dart';
import '../components/custom_bottom_nav.dart';
import '../components/movie_card.dart';
import '../components/movie_card_detailed.dart';
import '../components/section.dart';
import '../model/movie.dart';
import '../model/product.dart';
import '../state_manager/state_manager.dart';
import 'movie_details _screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPopularMovies();
    getUpcomingMovies();
  }

  List<Movie>? popularMovies;
  List<Movie>? upcomingMovies;
  bool isGottenPopular = false;
  bool isGottenUpcoming = false;

  String upcoming = 'Upcoming';
  String popular = 'Popular';

  getPopularMovies() async {
    popularMovies = await ApiService().getPopularMovies();
    if (popularMovies != null) {
      setState(() {
        isGottenPopular = true;
      });
    }
  }

  getUpcomingMovies() async {
    upcomingMovies = await ApiService().getUpcomingMovies();
    if (upcomingMovies != null) {
      setState(() {
        isGottenUpcoming = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String movieLength = '1h 47m';
    return Consumer<StateManager>(
      builder: (context, stateManager, child) => Scaffold(
        drawer: CustomDrawer(),
        drawerEnableOpenDragGesture: false,
        body: HomeActualScreen(
            popularMovies: popularMovies,
            popular: popular,
            isGottenPopular: isGottenPopular,
            upcomingMovies: upcomingMovies,
            upcoming: upcoming,
            isGottenUpcoming: isGottenUpcoming),
      ),
    );
  }
}

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
              child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/movie_grid.jpg',
                    ))),
          )),
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: iconColor),
              onPressed: () {
                if (textController.text != '') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              SearchMovieScreen(query: textController.text)));
                }
              },
              child: Text(
                'Search',
                style: Theme.of(context).textTheme.headline1?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.grey[200]),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: AnimSearchBar(
              closeSearchOnSuffixTap: false,
              width: 400.w,
              textController: textController,
              onSuffixTap: () {
                setState(() {
                  textController.clear();
                });
              },
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const BookMarkScreen()));
            },
            leading: CircleAvatar(
              radius: 22.r,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.bookmark_added_rounded,
                color: iconColor,
                size: 25.sp,
              ),
            ),
            title: Text(
              'saved movies',
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  ?.copyWith(color: iconColor.withOpacity(0.5)),
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => const CustomDialog(),
              );
            },
            leading: CircleAvatar(
              radius: 22.r,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.details,
                color: iconColor,
                size: 25.sp,
              ),
            ),
            title: Text(
              'about',
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  ?.copyWith(color: iconColor.withOpacity(0.5)),
            ),
          )
        ],
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
        ),
        height: 250.h,
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
              'About',
              style: Theme.of(context).textTheme.headline1,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeActualScreen extends StatelessWidget {
  const HomeActualScreen({
    Key? key,
    required this.popularMovies,
    required this.popular,
    required this.isGottenPopular,
    required this.upcomingMovies,
    required this.upcoming,
    required this.isGottenUpcoming,
  }) : super(key: key);

  final List<Movie>? popularMovies;
  final String popular;
  final bool isGottenPopular;
  final List<Movie>? upcomingMovies;
  final String upcoming;
  final bool isGottenUpcoming;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CategoryScreen(
                                movies: popularMovies!,
                                category: popular,
                              ),
                            ),
                          );
                        },
                        section: 'Popular',
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    isGottenPopular
                        ? Padding(
                            padding: EdgeInsets.only(left: 24.w),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  6,
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
                          )
                        : SizedBox(
                            height: 300.h,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              child: const ShimmerRowList(),
                            )),
                    SizedBox(
                      height: 24.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Section(
                          section: 'Upcoming',
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CategoryScreen(
                                          movies: upcomingMovies!,
                                          category: upcoming,
                                        )));
                          }),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    isGottenUpcoming
                        ? Column(
                            children: List.generate(
                              7,
                              (index) => InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => MovieDetailScreen(
                                          movie: upcomingMovies![index]),
                                    ),
                                  );
                                },
                                child: MovieCardDetailed(
                                  movie: upcomingMovies![index],
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: const ShimmerColumnList(),
                          )
                  ],
                ),
              ));
            }, childCount: 1),
          )
        ],
      ),
    );
  }
}

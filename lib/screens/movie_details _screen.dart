import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hmm_movie_review_app/components/rating_row.dart';
import 'package:hmm_movie_review_app/components/section.dart';
import 'package:hmm_movie_review_app/model/product.dart';

import '../components/category_builder.dart';
import '../constants.dart';
import '../model/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  MovieDetailScreen({Key? key, required this.movie}) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 300.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://image.tmdb.org/t/p/original/${movie.backdropPath!}'),
                  )),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back),
                              color: Colors.white,
                              iconSize: 30.sp,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.menu),
                              color: Colors.white,
                              iconSize: 30.sp,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 34.h,
                      ),
                      Center(
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.play_circle_fill_sharp),
                              color: Colors.white,
                              iconSize: 45.sp,
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              'Play Trailer',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CustomContainer(
            movie: movie,
          ),
        ],
      ),
    ));
  }
}

class CustomContainer extends StatelessWidget {
  CustomContainer({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 240.h),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r),
            topRight: Radius.circular(15.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 198.w,
                  height: 60.h,
                  child: Text(
                    movie.originalTitle!,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Icon(
                  Icons.bookmark_border,
                  color: Colors.black,
                  size: 30.sp,
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            RatingRow(movieRating: movie.voteAverage!),
            SizedBox(
              height: 8.h,
            ),
            const CategoryBuilder(),
            SizedBox(
              height: 16.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MovieDetailColumn(
                  title: 'Length',
                  subTitle: '2h 28min',
                ),
                SizedBox(
                  width: 52.w,
                ),
                const MovieDetailColumn(
                  title: 'Length',
                  subTitle: '2h 28min',
                ),
                SizedBox(
                  width: 52.w,
                ),
                const MovieDetailColumn(
                  title: 'Length',
                  subTitle: '2h 28min',
                ),
              ],
            ),
            SizedBox(
              height: 24.h,
            ),
            Text(
              'Description',
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              movie.overview!,
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              height: 20.h,
            ),
            Section(section: 'Cast', press: () {}),
            SizedBox(
              height: 17.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                4,
                (index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(7.r),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/original/${movie.posterPath!}',
                        height: 80.h,
                        width: 70.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      'Actor Name',
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(color: iconColor),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MovieDetailColumn extends StatelessWidget {
  const MovieDetailColumn({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(
          height: 6.h,
        ),
        Text(
          subTitle,
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.copyWith(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

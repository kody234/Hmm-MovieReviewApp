import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hmm_movie_review_app/components/rating_row.dart';

import '../constants.dart';

class MovieCardDetailed extends StatelessWidget {
  const MovieCardDetailed({
    Key? key,
    required this.movieLength,
  }) : super(key: key);

  final String movieLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24.w, bottom: 14.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/movie_logo.png',
              fit: BoxFit.cover,
              height: 128.h,
              width: 85.w,
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Spiderman: No Way Home',
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(
                height: 14.h,
              ),
              const RatingRow(),
              SizedBox(
                height: 8.h,
              ),
              Row(
                children: List.generate(
                  genres.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Container(
                      height: 16.h,
                      width: 61.w,
                      decoration: BoxDecoration(
                          color: chipColor,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Center(
                        child: Text(
                          genres[index],
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text('length: $movieLength'),
            ],
          )
        ],
      ),
    );
  }
}

List genres = ['Action', 'Adventure', 'Fantasy'];

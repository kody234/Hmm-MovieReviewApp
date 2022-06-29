import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hmm_movie_review_app/components/rating_row.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 24.w),
      child: SizedBox(
        width: 140.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 202.h,
              width: 140.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
                image: const DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/movie_logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              'Spiderman: No Way Home',
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: 8.h,
            ),
            const RatingRow()
          ],
        ),
      ),
    );
  }
}

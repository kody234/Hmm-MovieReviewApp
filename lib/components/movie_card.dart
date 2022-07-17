import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hmm_movie_review_app/components/rating_row.dart';
import 'package:hmm_movie_review_app/model/product.dart';

import '../model/movie.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 24.w),
      child: SizedBox(
        width: 140.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                height: 202.h,
                width: 140.w,
                imageUrl:
                    'https://image.tmdb.org/t/p/original${movie.posterPath!}',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress)),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  size: 100,
                  color: Colors.red,
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              movie.originalTitle!,
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: 8.h,
            ),
            RatingRow(
              movieRating: movie.voteAverage!,
            )
          ],
        ),
      ),
    );
  }
}

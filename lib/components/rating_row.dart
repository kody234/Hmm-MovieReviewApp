import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingRow extends StatelessWidget {
  const RatingRow({
    Key? key,
    required this.movieRating,
  }) : super(key: key);
  final double? movieRating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 18.sp,
        ),
        SizedBox(
          width: 4.h,
        ),
        Text(
          movieRating.toString() + ' IMDb',
          style: Theme.of(context).textTheme.headline4,
        )
      ],
    );
  }
}

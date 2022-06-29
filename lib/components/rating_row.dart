import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingRow extends StatelessWidget {
  const RatingRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 12.sp,
        ),
        SizedBox(
          width: 4.h,
        ),
        Text(
          '9.1/10 IMDb',
          style: Theme.of(context).textTheme.headline4,
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';
import 'movie_card_detailed.dart';

class CategoryBuilder extends StatelessWidget {
  const CategoryBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        genres.length,
        (index) => Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: Container(
            height: 16.h,
            width: 61.w,
            decoration: BoxDecoration(
                color: chipColor, borderRadius: BorderRadius.circular(10.r)),
            child: Center(
              child: Text(
                genres[index],
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

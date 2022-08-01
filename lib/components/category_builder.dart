import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';
import 'movie_card_detailed.dart';

class CategoryBuilder extends StatelessWidget {
  const CategoryBuilder({
    Key? key,
    required this.label2,
  }) : super(key: key);

  final List label2;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: List.generate(
      label2.length,
      (index) => Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: Chip(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: const VisualDensity(horizontal: 0.0, vertical: -4),
          labelPadding: EdgeInsets.zero,
          backgroundColor: chipColor,
          label: Text(
            label2[index]['name'],
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    ));
  }
}

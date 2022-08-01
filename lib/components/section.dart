import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Section extends StatelessWidget {
  const Section({
    Key? key,
    required this.section,
    required this.press,
  }) : super(key: key);
  final String section;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          height: 40,
        ),
        Expanded(
          child: Text(
            section,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        SizedBox(
          height: 27.h,
          width: 75.w,
          child: OutlinedButton(
            onPressed: press,
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Center(
              child: Text(
                'See more',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(fontSize: 14.sp),
              ),
            ),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: InkWell(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: Image(
            image: Svg(
              'assets/menu_icon.svg',
              color: iconColor,
              size: Size(
                28.w,
                28.h,
              ),
            ),
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'FilmKu',
            style: Theme.of(context).textTheme.headline1,
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
      actions: [
        Icon(
          Icons.notifications_active_outlined,
          color: iconColor,
          size: 28.sp,
        ),
        SizedBox(
          width: 25.w,
        ),
      ],
    );
  }
}

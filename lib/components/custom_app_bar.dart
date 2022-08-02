import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hive/hive.dart';
import 'package:hmm_movie_review_app/screens/bookmark_screen.dart';

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
        child: IconButton(
            iconSize: 23.sp,
            color: iconColor,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu_rounded)),
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
        IconButton(
          icon: Hive.box('savedMovies').isNotEmpty
              ? const Icon(Icons.bookmark)
              : const Icon(Icons.bookmark_border),
          color: iconColor,
          iconSize: 28.sp,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const BookMarkScreen()));
          },
        ),
        SizedBox(
          width: 25.w,
        ),
      ],
    );
  }
}

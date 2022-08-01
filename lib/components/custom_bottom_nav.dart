import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hmm_movie_review_app/constants.dart';
import 'package:hmm_movie_review_app/state_manager/state_manager.dart';
import 'package:provider/provider.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    Key? key,
    required this.isSelected,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final bool isSelected;
  final String icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: SizedBox(
        width: 30.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageIcon(
              AssetImage(icon),
              color: iconColor,
            ),
            SizedBox(
              height: 5.h,
            ),
            Visibility(
              visible: isSelected,
              child: Container(
                height: 6,
                width: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: iconColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<NavIcon> navIcons = [
  NavIcon(icon: homeIconUrl, index: 0),
  NavIcon(icon: searchIconUrl, index: 1),
  NavIcon(icon: bookMarkIconUrl, index: 2),
];

class NavIcon {
  final String icon;
  final int index;
  NavIcon({required this.icon, required this.index});
}

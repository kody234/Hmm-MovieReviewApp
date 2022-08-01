import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerRowList extends StatelessWidget {
  const ShimmerRowList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;

    return SafeArea(
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          offset += 5;
          time = 800 + offset;

          if (kDebugMode) {
            print(time);
          }

          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: Colors.grey[300]!,
                child: const ShimmerRow(),
                period: Duration(milliseconds: time),
              ));
        },
      ),
    );
  }
}

class ShimmerRow extends StatelessWidget {
  const ShimmerRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double containerWidth = 180;
    double containerHeight = 15;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 202.h,
            width: 140.w,
            color: Colors.grey,
          ),
          const SizedBox(height: 15),
          Container(
            height: containerHeight,
            width: containerWidth,
            color: Colors.grey,
          ),
          const SizedBox(height: 5),
          Container(
            height: containerHeight,
            width: containerWidth,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

class ShimmerColumnList extends StatelessWidget {
  const ShimmerColumnList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;

    return SafeArea(
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          offset += 5;
          time = 800 + offset;

          if (kDebugMode) {
            print(time);
          }

          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: Colors.grey[300]!,
                child: const ShimmerColumn(),
                period: Duration(milliseconds: time),
              ));
        },
      ),
    );
  }
}

class ShimmerColumn extends StatelessWidget {
  const ShimmerColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double containerWidth = 180;
    double containerHeight = 15;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        children: [
          Container(
            height: 128.h,
            width: 85.w,
            color: Colors.grey,
          ),
          SizedBox(
            width: 16.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: containerHeight,
                width: containerWidth,
                color: Colors.grey,
              ),
              SizedBox(height: 14.h),
              Container(
                height: containerHeight,
                width: containerWidth,
                color: Colors.grey,
              ),
              SizedBox(height: 8.h),
              Container(
                height: containerHeight,
                width: containerWidth,
                color: Colors.grey,
              ),
              SizedBox(height: 8.h),
              Container(
                height: containerHeight,
                width: containerWidth,
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

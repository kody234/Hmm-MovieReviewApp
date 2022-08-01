import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hmm_movie_review_app/constants.dart';
import 'package:hmm_movie_review_app/screens/trailer_screen.dart';

class ListTrailerScreen extends StatelessWidget {
  const ListTrailerScreen(
      {Key? key, required this.trailers, required this.imagePath})
      : super(key: key);

  final List trailers;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[200],
          foregroundColor: iconColor,
          title: Text(
            'Trailers',
            style: TextStyle(fontSize: 23.sp),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(
                  trailers.length,
                  (index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => MyHomePage(
                                        id: trailers[index]['key'],
                                      )));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(imagePath),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  trailers[index]['name'],
                                  style: TextStyle(
                                      fontSize: 23.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Center(
                                  child: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => MyHomePage(
                                                        id: trailers[index]
                                                            ['key'],
                                                      )));
                                        },
                                        icon: const Icon(
                                            Icons.play_circle_fill_sharp),
                                        color: Colors.white,
                                        iconSize: 45.sp,
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text(
                                        'Watch Trailer',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
            ),
          ),
        ));
  }
}

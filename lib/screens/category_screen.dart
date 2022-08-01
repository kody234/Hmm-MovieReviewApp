import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hmm_movie_review_app/constants.dart';
import 'package:hmm_movie_review_app/screens/movie_details%20_screen.dart';
import 'package:transparent_image/transparent_image.dart';

import '../components/category_builder.dart';
import '../model/movie.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key, required this.movies, required this.category})
      : super(key: key);
  final List<Movie?> movies;
  final String category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        foregroundColor: iconColor,
        title: Text(
          category,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.sp),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30.h,
          ),
          Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.w),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) {
                                return MovieDetailScreen(movie: movies[index]!);
                              },
                            ),
                          );
                        },
                        child: ClipPath(
                          clipper: MyClipper(),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            height: 200.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              image: DecorationImage(
                                  opacity: 5,
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.7),
                                      BlendMode.dstATop),
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/original/${movies[index]?.posterPath}')),
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    width: 110.w,
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/original/${movies[index]?.posterPath}',
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Image.memory(kTransparentImage),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 20.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          movies[index]!.originalTitle!,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 22.sp,
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              '${movies[index]!.voteAverage}',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 17.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          '${movies[index]!.releaseDate?.toIso8601String()}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Expanded(
                                          child: Text(
                                            movies[index]!.overview!,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                ?.copyWith(
                                                    letterSpacing: 1,
                                                    wordSpacing: 1,
                                                    fontSize: 20.sp,
                                                    color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10.h,
                      );
                    },
                    itemCount: movies.length)),
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip

    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2, 0);

    path.quadraticBezierTo(
        4 * size.width / 9, size.height / 5, 3 * size.width / 9, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

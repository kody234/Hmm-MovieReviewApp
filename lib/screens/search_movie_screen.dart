import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hmm_movie_review_app/constants.dart';
import 'package:hmm_movie_review_app/services/api_service.dart';
import 'package:transparent_image/transparent_image.dart';

import '../model/movie.dart';
import 'category_screen.dart';
import 'movie_details _screen.dart';

class SearchMovieScreen extends StatefulWidget {
  const SearchMovieScreen({Key? key, required this.query}) : super(key: key);

  final String query;

  @override
  State<SearchMovieScreen> createState() => _SearchMovieScreenState();
}

class _SearchMovieScreenState extends State<SearchMovieScreen> {
  bool isDone = false;
  late List<Movie?>? movies;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchMovie();
  }

  searchMovie() async {
    movies = await ApiService().searchMovie(widget.query);
    if (movies != null) {
      setState(() {
        isDone = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        foregroundColor: iconColor,
        iconTheme: IconThemeData(size: 27.sp),
        title: Text(
          'results for ${widget.query}',
          style: Theme.of(context).textTheme.headline1?.copyWith(
              fontWeight: FontWeight.bold, fontSize: 25.sp, letterSpacing: 1),
        ),
      ),
      body: isDone
          ? Column(
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
                                      return MovieDetailScreen(
                                          movie: movies![index]!);
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
                                            'https://image.tmdb.org/t/p/original/${movies![index]?.posterPath}')),
                                    borderRadius: BorderRadius.circular(25.r),
                                  ),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          width: 110.w,
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/original/${movies![index]?.posterPath}',
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
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
                                                movies![index]!.originalTitle!,
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
                                                    '${movies![index]!.voteAverage}',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 17.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text(
                                                '${movies![index]!.releaseDate?.toIso8601String()}',
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
                                                  movies![index]!.overview!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                          itemCount: movies!.length)),
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(
                color: iconColor,
              ),
            ),
    );
  }
}

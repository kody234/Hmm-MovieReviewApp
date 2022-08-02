import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hmm_movie_review_app/database/local_storage_repository.dart';
import 'package:transparent_image/transparent_image.dart';

import '../constants.dart';
import '../model/movie.dart';
import 'category_screen.dart';
import 'movie_details _screen.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({Key? key}) : super(key: key);

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box('savedMovies');
    List<Movie>? savedMovies = LocalStorageRepository().getSavedMovies(box);
    bool isDone = true;

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              color: Colors.red,
              iconSize: 25.sp,
              onPressed: () {
                setState(() {
                  LocalStorageRepository().clearSavedList(box).then(
                        (value) => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'all movies have been removed',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.sp),
                            ),
                          ),
                        ),
                      );
                });
              },
              icon: const Icon(Icons.delete),
            )
          ],
          title: Text(
            'Saved Movies',
            style: Theme.of(context).textTheme.headline1,
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[200],
          foregroundColor: iconColor,
        ),
        body: Hive.box('savedMovies').isNotEmpty
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
                                            movie: savedMovies[index]);
                                      },
                                    ),
                                  );
                                },
                                child: ClipPath(
                                  clipper: MyClipper(),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w),
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
                                              'https://image.tmdb.org/t/p/original/${savedMovies[index].posterPath}')),
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
                                            height: 180.h,
                                            imageUrl:
                                                'https://image.tmdb.org/t/p/original/${savedMovies[index].posterPath}',
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
                                                  savedMovies[index]
                                                      .originalTitle!,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.w900,
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
                                                      '${savedMovies[index].voteAverage}',
                                                      textAlign:
                                                          TextAlign.start,
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
                                                  '${savedMovies[index].releaseDate?.toIso8601String()}',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize: 17.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Text(
                                                  savedMovies[index].overview!,
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
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: IconButton(
                                                      color: Colors.red,
                                                      iconSize: 30.sp,
                                                      onPressed: () {
                                                        setState(() {
                                                          LocalStorageRepository()
                                                              .removeMovieFromSavedList(
                                                                  box,
                                                                  savedMovies[
                                                                      index])
                                                              .then(
                                                                (value) => ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                    content:
                                                                        Text(
                                                                      '${savedMovies[index].title} has been removed from favourites',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15.sp),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                        });
                                                      },
                                                      icon: const Icon(
                                                          Icons.delete),
                                                    ),
                                                  ),
                                                )
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
                            itemCount: savedMovies.length)),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              )
            : Center(
                child: Text(
                  'You have no favourites!',
                  style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      color: iconColor),
                ),
              ));
  }
}

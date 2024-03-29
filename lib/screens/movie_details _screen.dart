import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hmm_movie_review_app/components/rating_row.dart';
import 'package:hmm_movie_review_app/components/section.dart';
import 'package:hmm_movie_review_app/database/local_storage_repository.dart';
import 'package:hmm_movie_review_app/model/product.dart';
import 'package:hmm_movie_review_app/screens/casts_screen.dart';
import 'package:hmm_movie_review_app/screens/list_trailer_screen.dart';
import 'package:hmm_movie_review_app/services/api_service.dart';
import 'package:transparent_image/transparent_image.dart';

import '../components/category_builder.dart';
import '../constants.dart';
import '../model/movie.dart';

class MovieDetailScreen extends StatefulWidget {
  MovieDetailScreen({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMovieDetails();
  }

  getMovieDetails() async {
    details = await ApiService().getMovieDetails(movieId: widget.movie.id);
    if (details != null) {
      setState(() {
        isGottenDetails = true;
      });
    }
  }

  Map<String, dynamic>? details;
  bool isGottenDetails = false;
  var box = Hive.box('savedMovies');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isGottenDetails
            ? Stack(
                children: [
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 300.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/original/${widget.movie.backdropPath!}'),
                          )),
                        ),
                      ],
                    ),
                  ),
                  CustomContainer(
                    movie: widget.movie,
                    details: details,
                    box: box,
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: iconColor,
                ),
              ));
  }
}

class CustomContainer extends StatefulWidget {
  const CustomContainer({
    Key? key,
    required this.movie,
    required this.details,
    required this.box,
  }) : super(key: key);
  final Movie movie;
  final Map<String, dynamic>? details;
  final Box box;

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  bool isSaved(key) {
    return widget.box.containsKey(key);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(
                height: 25.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white,
                      iconSize: 30.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 34.h,
              ),
              Center(
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ListTrailerScreen(
                                      trailers: widget.details!['videos']
                                          ['results'],
                                      imagePath:
                                          'https://image.tmdb.org/t/p/original/${widget.movie.backdropPath!}',
                                    )));
                      },
                      icon: const Icon(Icons.play_circle_fill_sharp),
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
          Container(
            margin: EdgeInsets.only(top: 26.h),
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.r),
                topRight: Radius.circular(15.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 198.w,
                      height: 60.h,
                      child: Text(
                        widget.movie.originalTitle!,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {});

                        LocalStorageRepository()
                            .addMovieToSavedList(widget.box, widget.movie)
                            .then(
                              (value) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text(
                                    '${widget.movie.title} has been added to favourites',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp),
                                  ),
                                ),
                              ),
                            );
                      },
                      child: Icon(
                        isSaved(widget.movie.id)
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: iconColor,
                        size: 30.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                RatingRow(movieRating: widget.movie.voteAverage),
                SizedBox(
                  height: 8.h,
                ),
                CategoryBuilder(label2: widget.details!['genres']),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MovieDetailColumn(
                      title: 'Language',
                      subTitle: widget.details!['original_language'],
                    ),
                    SizedBox(
                      width: 52.w,
                    ),
                    MovieDetailColumn(
                      title: 'Rating',
                      subTitle: '${widget.movie.voteAverage}',
                    ),
                    SizedBox(
                      width: 52.w,
                    ),
                    MovieDetailColumn(
                      title: 'Release date',
                      subTitle: widget.details!['release_date'],
                    ),
                  ],
                ),
                SizedBox(
                  height: 24.h,
                ),
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  widget.movie.overview ?? '',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      letterSpacing: 1, wordSpacing: 1, fontSize: 20.sp),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Section(
                    section: 'Cast',
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CastScreen(
                                    details: widget.details,
                                    movie: widget.movie,
                                  )));
                    }),
                SizedBox(
                  height: 17.h,
                ),
                SizedBox(
                  height: 240.h,
                  child: ListView.builder(
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 85.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(7.r),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/original/${widget.details!['credits']['cast'][index]['profile_path']}',
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Image.memory(kTransparentImage),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.error,
                                    size: 100.sp,
                                    color: Colors.red,
                                  ),
                                  height: 80.h,
                                  width: 70.w,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                widget.details!['credits']['cast'][index]
                                    ['name'],
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(color: iconColor),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                widget.details!['credits']['cast'][index]
                                    ['character'],
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(
                                        color: iconColor,
                                        fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MovieDetailColumn extends StatelessWidget {
  const MovieDetailColumn({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);
  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(
          height: 6.h,
        ),
        Text(
          subTitle ?? 'null',
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.copyWith(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hmm_movie_review_app/model/movie.dart';
import 'package:transparent_image/transparent_image.dart';

import '../constants.dart';

class CastScreen extends StatelessWidget {
  const CastScreen({Key? key, required this.details, required this.movie})
      : super(key: key);
  final Map<String, dynamic>? details;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    List casts = details!['credits']['cast'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        foregroundColor: iconColor,
        title: Text(
          'Casts',
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7), BlendMode.dstATop),
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/original${movie.posterPath!}'))),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: GridView.builder(
                    itemCount: casts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, mainAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(7.r),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/original/${details!['credits']['cast'][index]['profile_path']}',
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      Image.memory(kTransparentImage),
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                size: 100.sp,
                                color: Colors.red,
                              ),
                              height: 90.h,
                              width: 90.w,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            details!['credits']['cast'][index]['name'],
                            textAlign: TextAlign.start,
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      color: iconColor,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            details!['credits']['cast'][index]['character'],
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(
                                    overflow: TextOverflow.ellipsis,
                                    color: iconColor,
                                    fontWeight: FontWeight.w700),
                          )
                        ],
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

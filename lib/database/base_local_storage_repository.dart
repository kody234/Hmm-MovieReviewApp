import 'package:hive/hive.dart';
import 'package:hmm_movie_review_app/model/movie.dart';

abstract class BaseLocalStorageRepository {
  Future<Box> openBox();
  List<Movie> getSavedMovies(Box box);
  Future<void> addMovieToSavedList(Box box, Movie movie);
  Future<void> removeMovieFromSavedList(Box box, Movie movie);
  Future<void> clearSavedList(Box box);
}

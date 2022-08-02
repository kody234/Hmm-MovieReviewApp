import 'package:hive/hive.dart';
import 'package:hmm_movie_review_app/database/base_local_storage_repository.dart';
import 'package:hmm_movie_review_app/model/movie.dart';

class LocalStorageRepository extends BaseLocalStorageRepository {
  String boxName = 'savedMovies';

  @override
  Future<Box> openBox() async {
    // TODO: implement openBox
    Box box = await Hive.openBox(boxName);
    return box;
  }

  @override
  List<Movie> getSavedMovies(Box box) {
    // TODO: implement getSavedMovies
    return box.values.toList().cast<Movie>();
  }

  @override
  Future<void> addMovieToSavedList(Box box, Movie movie) async {
    // TODO: implement addMovieToSavedList
    await box.put(movie.id, movie);
  }

  @override
  Future<void> removeMovieFromSavedList(Box box, Movie movie) async {
    // TODO: implement removeMovieFromSavedList
    await box.delete(movie.id);
  }

  @override
  Future<void> clearSavedList(Box box) async {
    // TODO: implement clearSavedList
    await box.clear();
  }
}

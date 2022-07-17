import 'dart:convert';

import '../model/movie.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Movie>?> getPopularMovies() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=79ce9c64e2645e9baff2e363b9869940&language=en-US&page=1');
    try {
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        print(response.body);

        var json = jsonDecode(response.body);
        List movies = json['results'];
        List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
        return movieList;
      }
    } catch (error) {
      print(error);
    }
  }
}

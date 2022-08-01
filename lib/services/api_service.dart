import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

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
    return null;
  }

  Future<List<Movie>?> getUpcomingMovies() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=79ce9c64e2645e9baff2e363b9869940&language=en-US&page=1');
    try {
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.body);
        }

        var json = jsonDecode(response.body);
        List movies = json['results'];
        List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
        return movieList;
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    return null;
  }

  Future<Map<String, dynamic>?> getMovieDetails({required int? movieId}) async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId?api_key=79ce9c64e2645e9baff2e363b9869940&language=en-US&append_to_response=credits,videos');
    try {
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.body);
        }

        var json = jsonDecode(response.body);
        // List movies = json['results'];
        // List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
        return json;
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    return null;
  }

  Future<List<Movie?>?> searchMovie(String query) async {
    var client = http.Client();
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=79ce9c64e2645e9baff2e363b9869940&query=$query');

    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        debugPrint(response.body);

        var json = jsonDecode(response.body);
        List movies = json['results'];
        List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();

        return movieList;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}

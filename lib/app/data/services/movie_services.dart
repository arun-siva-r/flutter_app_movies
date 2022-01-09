import 'dart:convert';

import 'package:flutter_app_movies/app/data/models/movie_details.dart';
import 'package:flutter_app_movies/app/data/models/movie_list_details.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class MovieServices {
  static Future<MovieDetails?> getMovieDetails(dynamic id) async {
    Response response = await http
        .get(Uri.parse('https://omdbapi.com/?i=' + id + '&apikey=35882e11'));
    dynamic jsonAppData = json.decode(response.body);
    if (jsonAppData != null) {
      final MovieDetails movieDetails = MovieDetails.fromJson(jsonAppData);
      return movieDetails;
    }

    return null;
  }

  static Future<List<MovieListDetails>?> getSearchDetails(
      String keyWord) async {
    Response response = await http.get(
        Uri.parse('https://omdbapi.com/?s=' + keyWord + '&apikey=35882e11'));
    dynamic jsonAppData = json.decode(response.body);
    final dynamic responseMoviesDetails = jsonAppData['Search'];
    if (jsonAppData != null && responseMoviesDetails != null) {
      final List<MovieListDetails> movieList = responseMoviesDetails
          .map<MovieListDetails>(
              (dynamic json) => MovieListDetails.fromJson(json))
          .toList();
      return movieList;
    }

    return null;
  }
}

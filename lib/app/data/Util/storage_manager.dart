import 'dart:convert';
import 'dart:io';

import 'package:flutter_app_movies/app/data/models/movie_details.dart';
import 'package:flutter_app_movies/app/data/models/movie_list_details.dart';
import 'package:path_provider/path_provider.dart';

class MovieStorage {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/movieDetails.txt');
  }

  static Future<File> get _localListFile async {
    final path = await _localPath;
    return File('$path/movieDetails.txt');
  }

  static Future<MovieDetails?> readMovieDetails() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      return MovieDetails.fromJson(jsonDecode(contents));
    } catch (e) {
      return null;
    }
  }

  static Future<File> writeMovieDetails(MovieDetails details) async {
    final file = await _localFile;
    return file.writeAsString(jsonEncode(details));
  }

  static Future<List<MovieListDetails>?> readMovieList() async {
    try {
      final file = await _localListFile;
      final contents = await file.readAsString();
      final dynamic jsonContent = jsonDecode(contents);
      final List<MovieListDetails> movieList = jsonContent
          .map<MovieListDetails>(
              (dynamic json) => MovieListDetails.fromJson(json))
          .toList();
      return movieList;
    } catch (e) {
      return null;
    }
  }

  static Future<File> writeMovieList(List<MovieListDetails> details) async {
    final file = await _localListFile;
    return file.writeAsString(jsonEncode(details));
  }
}

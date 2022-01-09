import 'dart:convert';

import 'package:flutter_app_movies/app/data/models/movie_details.dart';
import 'package:get_storage/get_storage.dart';

const String movieDetailsAPI = 'movieDetailsAPI';

dynamic box = GetStorage();

class Util {
  static void setMovieDetailsModel(dynamic movieDetails) {
    final dynamic box = GetStorage();
    final String entriesJson = json.encode(movieDetails);
    box.write(movieDetailsAPI, entriesJson);
  }

  static MovieDetails? getMovieDetailsModel() {
    final dynamic box = GetStorage();
    final String? stringRead = box.read(movieDetailsAPI);

    if (stringRead != null) {
      final dynamic entriesDeserialized = json.decode(stringRead);
      return MovieDetails.fromJson(entriesDeserialized);
    } else {
      return null;
    }
  }
}

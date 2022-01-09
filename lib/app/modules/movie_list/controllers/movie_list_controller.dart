import 'package:flutter/cupertino.dart';
import 'package:flutter_app_movies/app/data/Util/storage_manager.dart';
import 'package:flutter_app_movies/app/data/models/movie_list_details.dart';
import 'package:flutter_app_movies/app/data/services/movie_services.dart';
import 'package:get/get.dart';

class MovieListController extends GetxController {
  TextEditingController searchFieldController = TextEditingController();
  List<MovieListDetails> movieList = <MovieListDetails>[];
  double animatedWidth = 10, animatedHeight = 10;

  @override
  void onInit() async {
    getSearchResults();
    super.onInit();
  }

  Future<List<MovieListDetails>> getSearchResults({String? value}) async {
    try {
      movieList = await MovieServices.getSearchDetails(
              (value != null && value.isNotEmpty) ? value : 'Marvel') ??
          movieList;
    } catch (e) {
      movieList = await MovieStorage.readMovieList() ?? movieList;
    }
    MovieStorage.writeMovieList(movieList);
    update();
    updateAnimatedWidget();
    return movieList;
  }

  void updateAnimatedWidget() {
    animatedWidth = double.infinity;
    animatedHeight = double.infinity;
    update();
  }

  @override
  void onClose() {}
}

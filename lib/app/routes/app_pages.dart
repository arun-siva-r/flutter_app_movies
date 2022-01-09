import 'package:get/get.dart';

import 'package:flutter_app_movies/app/modules/movie_details/bindings/movie_details_binding.dart';
import 'package:flutter_app_movies/app/modules/movie_details/views/movie_details_view.dart';
import 'package:flutter_app_movies/app/modules/movie_list/bindings/movie_list_binding.dart';
import 'package:flutter_app_movies/app/modules/movie_list/views/movie_list_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MOVIE_LIST;

  static final routes = [
    GetPage(
      name: _Paths.MOVIE_DETAILS,
      page: () => MovieDetailsView(),
      binding: MovieDetailsBinding(),
    ),
    GetPage(
      name: _Paths.MOVIE_LIST,
      page: () => MovieListView(),
      binding: MovieListBinding(),
    ),
  ];
}

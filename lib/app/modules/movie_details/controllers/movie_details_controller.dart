import 'package:flutter_app_movies/app/data/Util/storage_util.dart';
import 'package:flutter_app_movies/app/data/models/movie_details.dart';
import 'package:get/get.dart';

class MovieDetailsController extends GetxController {
  late final MovieDetails movieDetails;
  late final List<String> movieGenres;

  @override
  Future<void> onInit() async {
    movieDetails = Util.getMovieDetailsModel()!;
    movieGenres = movieDetails.genre!.split(',');
    super.onInit();
  }

  @override
  void onClose() {}
}

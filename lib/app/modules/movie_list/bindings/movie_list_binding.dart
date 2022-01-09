import 'package:get/get.dart';

import '../controllers/movie_list_controller.dart';

class MovieListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieListController>(
      () => MovieListController(),
    );
  }
}

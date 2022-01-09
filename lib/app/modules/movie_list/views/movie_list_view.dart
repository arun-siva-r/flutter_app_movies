import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_movies/app/data/Util/storage_manager.dart';
import 'package:flutter_app_movies/app/data/Util/storage_util.dart';
import 'package:flutter_app_movies/app/data/models/movie_details.dart';
import 'package:flutter_app_movies/app/data/models/movie_list_details.dart';
import 'package:flutter_app_movies/app/data/services/movie_services.dart';
import 'package:flutter_app_movies/app/modules/movie_details/views/movie_details_view.dart';

import 'package:get/get.dart';

import '../controllers/movie_list_controller.dart';

class MovieListView extends GetView<MovieListController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieListController>(
      init: MovieListController(),
      builder: (MovieListController controller) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              'Browse',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              'Movies',
                              style: TextStyle(
                                  color: Colors.white38, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      Icon(
                        Icons.menu,
                        color: Colors.white38,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  TextFormField(
                    controller: controller.searchFieldController,
                    onChanged: (String value) {
                      controller.getSearchResults(value: value);
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      fillColor: Colors.white24,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white38,
                      ),
                      hintText: 'Search movies',
                      hintStyle: TextStyle(color: Colors.white38, fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide:
                            const BorderSide(color: Colors.white38, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide:
                            const BorderSide(color: Colors.white38, width: 1.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.08,
                  ),
                  Expanded(
                    child: controller.movieList.isNotEmpty
                        ? GridView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 15,
                                    childAspectRatio: 0.4),
                            itemCount: controller.movieList.length,
                            itemBuilder: (BuildContext context, int index) {
                              MovieListDetails movie =
                                  controller.movieList[index];
                              return GestureDetector(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Hero(
                                      tag: movie.title,
                                      child: Container(
                                        height: Get.height * 0.25,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          // image: DecorationImage(
                                          //     image:
                                          //         NetworkImage(movie.poster),
                                          //     fit: BoxFit.cover)
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: movie.poster,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      movie.title,
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                    Text(
                                      movie.year,
                                      style: TextStyle(
                                          color: Colors.white38, fontSize: 10),
                                    )
                                  ],
                                ),
                                onTap: () async {
                                  MovieDetails? movieDetails;
                                  try {
                                    movieDetails =
                                        await MovieServices.getMovieDetails(
                                            movie.imdbID);
                                  } catch (_) {
                                    print('No Internet');
                                  }

                                  if (movieDetails != null) {
                                    Util.setMovieDetailsModel(movieDetails);
                                    MovieStorage.writeMovieDetails(
                                        movieDetails);
                                  } else {
                                    movieDetails =
                                        await MovieStorage.readMovieDetails();
                                  }

                                  if (movieDetails != null &&
                                      movieDetails.imdbID == movie.imdbID) {
                                    Get.to(() => MovieDetailsView(),
                                        transition: Transition.fadeIn);
                                  }
                                },
                              );
                            })
                        : Container(
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color?>(Colors.red)),
                          ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

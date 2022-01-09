import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/movie_details_controller.dart';

class MovieDetailsView extends GetView<MovieDetailsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieDetailsController>(
        init: MovieDetailsController(),
        builder: (MovieDetailsController controller) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  bottom: Get.height * 0.5,
                  left: 0,
                  right: 0,
                  child: Hero(
                    tag: controller.movieDetails.title!,
                    child: Container(
                      height: Get.height * 0.5,
                      // decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //         image: NetworkImage(
                      //           controller.movieDetails.poster!,
                      //         ),
                      //         fit: BoxFit.cover)),
                      child: CachedNetworkImage(
                        imageUrl: controller.movieDetails.poster!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: Get.height * 0.35,
                  bottom: 0,
                  left: 20,
                  right: 20,
                  child: Container(
                    child: ClipRect(
                      clipBehavior: Clip.antiAlias,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 15,
                          sigmaY: 15,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10.0)),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  controller.movieDetails.title!,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.star_border,
                                    color: Colors.white38,
                                    size: 15,
                                  ),
                                  Text(controller.movieDetails.imdbRating!,
                                      style: TextStyle(
                                          color: Colors.white38, fontSize: 10)),
                                  SizedBox(
                                    width: Get.width * 0.08,
                                  ),
                                  Icon(
                                    Icons.alarm_on_outlined,
                                    color: Colors.white38,
                                    size: 15,
                                  ),
                                  Text(
                                    controller.movieDetails.runtime!,
                                    style: TextStyle(
                                        color: Colors.white38, fontSize: 10),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.03,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    controller.movieDetails.production!,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: _getGenres(),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Divider(
                                  height: 1.0,
                                  color: Colors.white10,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  controller.movieDetails.plot!,
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                      height: 2),
                                ),
                              ),
                              Text(
                                'Director:  ' +
                                    controller.movieDetails.director!,
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                    height: 1.2),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Text(
                                      'Writer:  ',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12,
                                          height: 1.2),
                                    ),
                                    Flexible(
                                      child: Text(
                                        controller.movieDetails.writer!,
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                            height: 1.2),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Text(
                                      'Actors:  ',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12,
                                          height: 1.2),
                                    ),
                                    Flexible(
                                      child: Text(
                                        controller.movieDetails.actors!,
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                            height: 1.2),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
            ),
          );
        });
  }

  List<Widget> _getGenres() {
    List<Widget> children = <Widget>[];
    if (controller.movieGenres.isNotEmpty) {
      for (int i = 0; i < controller.movieGenres.length; i++) {
        children.add(Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              color: Colors.white10),
          child: Text(
            controller.movieGenres[i],
            style: TextStyle(color: Colors.white, fontSize: 8),
          ),
        ));
      }
    }

    return children;
  }
}

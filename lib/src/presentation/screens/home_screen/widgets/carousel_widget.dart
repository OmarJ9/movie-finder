import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_finder/src/data/models/movie_model.dart';
import '../../../../config/app_route.dart';
import 'carousel_item.dart';

class CarouselWidget extends StatelessWidget {
  final List<MovieModel> list;
  const CarouselWidget({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: list
            .sublist(0, 5)
            .map(
              (item) => CarouselItem(
                  avatar: item.posterPath,
                  title: item.title,
                  genre: item.genreIds,
                  onTap: () {
                    context.push(AppRoute.details, extra: item.id);
                  }),
            )
            .toList(),
        options: CarouselOptions(
          aspectRatio: 1 / 0.8,
          autoPlay: true,
          viewportFraction: 1,
          autoPlayAnimationDuration: const Duration(seconds: 2),
          enlargeCenterPage: false,
        ));
  }
}

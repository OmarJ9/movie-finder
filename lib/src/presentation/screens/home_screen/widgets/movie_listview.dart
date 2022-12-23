import 'package:flutter/material.dart';
import 'package:movie_finder/src/data/models/movie_model.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/app_colors.dart';
import 'movie_card.dart';

class MovieListView extends StatelessWidget {
  const MovieListView({
    Key? key,
    required this.controller,
    required this.movies,
    required this.hasReachedMax,
  }) : super(key: key);

  final ScrollController controller;
  final List<MovieModel> movies;
  final bool hasReachedMax;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.h,
      width: 100.w,
      child: ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount: hasReachedMax ? movies.length : movies.length + 1,
        itemBuilder: (context, index) {
          if (index < movies.length) {
            return MovieCard(
              imgurl: movies[index].posterPath,
              rate: movies[index].voteAverage,
              id: movies[index].id,
            );
          } else {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: SizedBox(
                height: 30,
                width: 30,
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.green),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

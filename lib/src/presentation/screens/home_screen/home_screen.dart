import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_finder/src/blocs/upcoming_movies/upcoming_movies_event.dart';
import 'package:movie_finder/src/presentation/screens/home_screen/widgets/carousel_widget.dart';
import 'package:movie_finder/src/presentation/screens/home_screen/widgets/movie_listview.dart';
import 'package:sizer/sizer.dart';
import '../../../blocs/popular_movies/popular_movies_bloc.dart';
import '../../../blocs/popular_movies/popular_movies_event.dart';
import '../../../blocs/popular_movies/popular_movies_state.dart';
import '../../../blocs/trending_movies/trending_movies_bloc.dart';
import '../../../blocs/trending_movies/trending_movies_event.dart';
import '../../../blocs/trending_movies/trending_movies_state.dart';
import '../../../blocs/upcoming_movies/upcoming_movies_bloc.dart';
import '../../../blocs/upcoming_movies/upcoming_movies_state.dart';
import '../../../constants/app_colors.dart';
import '../../widgets/custom_error_widget.dart';
import '../../widgets/custom_text.dart';
import 'widgets/shimmer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _popularmoviescontroller = ScrollController();
  final ScrollController _recentmoviescontroller = ScrollController();
  final ScrollController _upcomingmoviescontroller = ScrollController();
  final InternetConnectionChecker _checker = InternetConnectionChecker();
  bool isOnline = false;
  late StreamSubscription<InternetConnectionStatus> listener;

  void _onPopularMovieScroll() async {
    if (_popularmoviescontroller.position.atEdge) {
      if (_popularmoviescontroller.position.pixels != 0 && isOnline) {
        context.read<PopularMovieBloc>().add(LoadPopularMovieEvent());
      }
    }
  }

  void _onRecentMovieScroll() {
    if (_recentmoviescontroller.position.atEdge) {
      if (_recentmoviescontroller.position.pixels != 0 && isOnline) {
        context.read<TrendingMovieBloc>().add(LoadTrendingMovieEvent());
      }
    }
  }

  void _onUpcomingMovieScroll() {
    if (_upcomingmoviescontroller.position.atEdge) {
      if (_upcomingmoviescontroller.position.pixels != 0 && isOnline) {
        context.read<UpcomingMovieBloc>().add(LoadUpcomingMovieEvent());
      }
    }
  }

  @override
  void initState() {
    _popularmoviescontroller.addListener(_onPopularMovieScroll);
    _recentmoviescontroller.addListener(_onRecentMovieScroll);
    _upcomingmoviescontroller.addListener(_onUpcomingMovieScroll);
    listener = _checker.onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          isOnline = true;
          break;
        case InternetConnectionStatus.disconnected:
          isOnline = false;
          break;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _popularmoviescontroller
      ..removeListener(_onPopularMovieScroll)
      ..dispose();
    _recentmoviescontroller
      ..removeListener(_onRecentMovieScroll)
      ..dispose();
    _upcomingmoviescontroller
      ..removeListener(_onUpcomingMovieScroll)
      ..dispose();
    listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PopularMovieBloc, PopularMovieState>(
          builder: (context, state) {
        switch (state.status) {
          case PopularMovieStatus.initial:
            return const ShimmerWidget();
          case PopularMovieStatus.success:
            return SingleChildScrollView(
              child: Column(
                children: [
                  CarouselWidget(
                    list: state.popularMovies,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            title: 'Popular Movies',
                            size: 12,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          BlocBuilder<PopularMovieBloc, PopularMovieState>(
                              builder: (context, state) {
                            switch (state.status) {
                              case PopularMovieStatus.initial:
                                return SizedBox(height: 25.h);

                              case PopularMovieStatus.success:
                                return MovieListView(
                                  controller: _popularmoviescontroller,
                                  movies: state.popularMovies,
                                  hasReachedMax: state.hasReachedMax,
                                );
                              case PopularMovieStatus.failure:
                                return _listviewErrorWidget(
                                  state.error,
                                  context,
                                  () {
                                    context
                                        .read<PopularMovieBloc>()
                                        .add(LoadPopularMovieEvent());
                                  },
                                );
                            }
                          }),
                          SizedBox(
                            height: 2.h,
                          ),
                          const CustomText(
                            title: 'Trending Movies',
                            size: 12,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          BlocBuilder<TrendingMovieBloc, TrendingMovieState>(
                              builder: (context, state) {
                            switch (state.status) {
                              case TrendingMovieStatus.initial:
                                return SizedBox(height: 25.h);

                              case TrendingMovieStatus.success:
                                return MovieListView(
                                  controller: _recentmoviescontroller,
                                  movies: state.trendingMovies,
                                  hasReachedMax: state.hasReachedMax,
                                );
                              case TrendingMovieStatus.failure:
                                return _listviewErrorWidget(
                                  state.error,
                                  context,
                                  () {
                                    context
                                        .read<TrendingMovieBloc>()
                                        .add(LoadTrendingMovieEvent());
                                  },
                                );
                            }
                          }),
                          SizedBox(
                            height: 2.h,
                          ),
                          const CustomText(
                            title: 'Upcoming Movies',
                            size: 12,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          BlocBuilder<UpcomingMovieBloc, UpcomingMovieState>(
                              builder: (context, state) {
                            switch (state.status) {
                              case UpcomingMovieStatus.initial:
                                return SizedBox(height: 25.h);

                              case UpcomingMovieStatus.success:
                                return MovieListView(
                                  controller: _upcomingmoviescontroller,
                                  movies: state.upcomingMovies,
                                  hasReachedMax: state.hasReachedMax,
                                );
                              case UpcomingMovieStatus.failure:
                                return _listviewErrorWidget(
                                  state.error,
                                  context,
                                  () {
                                    context
                                        .read<UpcomingMovieBloc>()
                                        .add(LoadUpcomingMovieEvent());
                                  },
                                );
                            }
                          }),
                          SizedBox(
                            height: 2.h,
                          ),
                        ],
                      ))
                ],
              ),
            );

          case PopularMovieStatus.failure:
            return CustomErrorWidget(
              error: state.error,
              func: () {
                context.read<PopularMovieBloc>().add(LoadPopularMovieEvent());
                context.read<TrendingMovieBloc>().add(LoadTrendingMovieEvent());
                context.read<UpcomingMovieBloc>().add(LoadUpcomingMovieEvent());
              },
            );
        }
      }),
    );
  }

  Container _listviewErrorWidget(
      String error, BuildContext context, VoidCallback func) {
    return Container(
      height: 15.h,
      width: 100.w,
      color: Colors.grey.shade300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            title: error,
            size: 12,
            color: AppColors.deepbleu,
          ),
          TextButton(
              onPressed: func,
              child: const CustomText(
                title: 'try again !',
                color: AppColors.green,
                size: 8,
              ))
        ],
      ),
    );
  }
}

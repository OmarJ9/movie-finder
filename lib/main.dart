import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_finder/src/blocs/movie_cast/movie_cast_bloc.dart';
import 'package:movie_finder/src/blocs/movie_details/movie_details_bloc.dart';
import 'package:movie_finder/src/blocs/movie_images/movie_images_bloc.dart';
import 'package:movie_finder/src/blocs/movie_video/movie_video_bloc.dart';
import 'package:movie_finder/src/blocs/popular_movies/popular_movies_bloc.dart';
import 'package:movie_finder/src/blocs/popular_movies/popular_movies_event.dart';
import 'package:movie_finder/src/blocs/search_movies/search_movie_bloc.dart';
import 'package:movie_finder/src/blocs/trending_movies/trending_movies_bloc.dart';
import 'package:movie_finder/src/blocs/trending_movies/trending_movies_event.dart';
import 'package:movie_finder/src/blocs/upcoming_movies/upcoming_movies_bloc.dart';
import 'package:movie_finder/src/blocs/upcoming_movies/upcoming_movies_event.dart';
import 'package:movie_finder/src/config/app_theme.dart';
import 'package:sizer/sizer.dart';
import 'package:movie_finder/src/di/get_it.dart' as get_it;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // load env
  await dotenv.load(fileName: '.env');

  // Initialize GetIt
  get_it.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<PopularMovieBloc>(
          create: (_) =>
              get_it.gI<PopularMovieBloc>()..add(LoadPopularMovieEvent()),
        ),
        BlocProvider<TrendingMovieBloc>(
          create: (_) =>
              get_it.gI<TrendingMovieBloc>()..add(LoadTrendingMovieEvent()),
        ),
        BlocProvider<UpcomingMovieBloc>(
          create: (_) =>
              get_it.gI<UpcomingMovieBloc>()..add(LoadUpcomingMovieEvent()),
        ),
        BlocProvider<SearchMovieBloc>(
          create: (_) => get_it.gI<SearchMovieBloc>(),
        ),
        BlocProvider<MovieDetailsBloc>(
          create: (_) => get_it.gI<MovieDetailsBloc>(),
        ),
        BlocProvider<MovieImagesBloc>(
          create: (_) => get_it.gI<MovieImagesBloc>(),
        ),
        BlocProvider<MovieCastBloc>(
          create: (_) => get_it.gI<MovieCastBloc>(),
        ),
        BlocProvider<MovieVideoBloc>(
          create: (_) => get_it.gI<MovieVideoBloc>(),
        ),
      ],
      child: const MovieFinder(),
    ),
  );
}

class MovieFinder extends StatelessWidget {
  const MovieFinder({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) => MaterialApp(
              title: 'Movie Finder',
              debugShowCheckedModeBanner: false,
              theme: AppThemes.light,
              darkTheme: AppThemes.dark,
            ));
  }
}

import 'package:get_it/get_it.dart';
import '../blocs/movie_cast/movie_cast_bloc.dart';
import '../blocs/movie_details/movie_details_bloc.dart';
import '../blocs/movie_images/movie_images_bloc.dart';
import '../blocs/movie_video/movie_video_bloc.dart';
import '../blocs/popular_movies/popular_movies_bloc.dart';
import '../blocs/search_movies/search_movie_bloc.dart';
import '../blocs/trending_movies/trending_movies_bloc.dart';
import '../blocs/upcoming_movies/upcoming_movies_bloc.dart';
import '../data/core/dio_client.dart';
import '../data/data_sources/remote_data_source.dart';
import '../data/repositories/movie_repo_impl.dart';

final gI = GetIt.I;

Future init() async {
  // Initialize DioClient.
  gI.registerLazySingleton<DioClient>(() => DioClient());

  // RemoteDataSource depends on DioClient
  gI.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(gI()));

  // Movie Repository depends on RemoteDataSource.
  gI.registerLazySingleton<MovieRepository>(() => MovieRepoImpl(gI()));

  // BLOCs
  gI.registerFactory<PopularMovieBloc>(() => PopularMovieBloc(gI()));
  gI.registerFactory<TrendingMovieBloc>(() => TrendingMovieBloc(gI()));
  gI.registerFactory<UpcomingMovieBloc>(() => UpcomingMovieBloc(gI()));
  gI.registerFactory<SearchMovieBloc>(() => SearchMovieBloc(gI()));
  gI.registerFactory<MovieDetailsBloc>(() => MovieDetailsBloc(gI()));
  gI.registerFactory<MovieImagesBloc>(() => MovieImagesBloc(gI()));
  gI.registerFactory<MovieCastBloc>(() => MovieCastBloc(gI()));
  gI.registerFactory<MovieVideoBloc>(() => MovieVideoBloc(gI()));
}

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_finder/src/data/models/cast_model.dart';
import 'package:movie_finder/src/data/models/movie_model.dart';
import 'package:movie_finder/src/data/models/video_model.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';
import '../models/movie_details_model.dart';

abstract class MovieRepository {
  Future<List<MovieModel>> getPopular({required int page});
  Future<List<MovieModel>> getTrending({required int page});
  Future<List<MovieModel>> getUpcoming({required int page});
  Future<List<MovieModel>> getSearchedMovie({required String query});
  Future<MovieDetailsModel> getMovieDetails({required int id});
  Future<List<dynamic>> getImages({required int id});
  Future<List<CastCrewModel>> getCastCrew({required int id});
  Future<List<VideoModel>> getVideo({required int id});
}

class MovieRepoImpl implements MovieRepository {
  final RemoteDataSource remotedatasource;
  final LocalDataSource localdatasource;
  final InternetConnectionChecker internetConnectionChecker;

  MovieRepoImpl(this.remotedatasource, this.localdatasource,
      this.internetConnectionChecker);
  @override
  Future<List<MovieModel>> getPopular({required int page}) async {
    try {
      if (await internetConnectionChecker.hasConnection) {
        final movies = await remotedatasource.getPopular(page: page);

        await localdatasource.cache(
            key: cachedPopularMovies, movies: movies, page: page);
        return movies;
      } else {
        final cachedmovies =
            await localdatasource.get(key: cachedPopularMovies, page: page);
        return cachedmovies;
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<MovieModel>> getTrending({required int page}) async {
    try {
      if (await internetConnectionChecker.hasConnection) {
        final movies = await remotedatasource.getTrending(page: page);

        await localdatasource.cache(
            key: cachedTrendingMovies, movies: movies, page: page);
        return movies;
      } else {
        final cachedmovies =
            await localdatasource.get(key: cachedTrendingMovies, page: page);
        return cachedmovies;
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<MovieModel>> getUpcoming({required int page}) async {
    try {
      if (await internetConnectionChecker.hasConnection) {
        final movies = await remotedatasource.getUpcoming(page: page);

        await localdatasource.cache(
            key: cachedUpcomingMovies, movies: movies, page: page);
        return movies;
      } else {
        final cachedmovies =
            await localdatasource.get(key: cachedUpcomingMovies, page: page);
        return cachedmovies;
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<MovieModel>> getSearchedMovie({required String query}) async {
    try {
      final movies = await remotedatasource.getSearchedMovie(query: query);
      return movies;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetails({required int id}) async {
    try {
      final movies = await remotedatasource.getMovieDetails(id: id);
      return movies;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> getImages({required int id}) async {
    try {
      final images = await remotedatasource.getImages(id: id);
      return images;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<CastCrewModel>> getCastCrew({required int id}) async {
    try {
      final cast = await remotedatasource.getCastCrew(id: id);
      return cast;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<VideoModel>> getVideo({required int id}) async {
    try {
      final videos = await remotedatasource.getVideo(id: id);
      return videos;
    } catch (_) {
      rethrow;
    }
  }
}

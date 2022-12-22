import '../core/dio_client.dart';
import '../models/cast_model.dart';
import '../models/movie_details_model.dart';
import '../models/movie_model.dart';
import '../models/video_model.dart';

abstract class RemoteDataSource {
  Future<List<MovieModel>> getPopular({required int page});
  Future<List<MovieModel>> getTrending({required int page});
  Future<List<MovieModel>> getUpcoming({required int page});
  Future<List<MovieModel>> getSearchedMovie({required String query});
  Future<MovieDetailsModel> getMovieDetails({required int id});
  Future<List<dynamic>> getImages({required int id});
  Future<List<CastCrewModel>> getCastCrew({required int id});
  Future<List<VideoModel>> getVideo({required int id});
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final DioClient _dioClient;

  RemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<MovieModel>> getPopular({required int page}) async {
    try {
      final response = await _dioClient.get(page: page, path: 'top_rated');
      final movies = response.data['results']
          .map<MovieModel>((json) => MovieModel.fromJson(json))
          .toList();
      return movies;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<MovieModel>> getTrending({required int page}) async {
    try {
      final response = await _dioClient.get(page: page, path: 'popular');
      final movies = response.data['results']
          .map<MovieModel>((json) => MovieModel.fromJson(json))
          .toList();
      return movies;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<MovieModel>> getUpcoming({required int page}) async {
    try {
      final response = await _dioClient.get(page: page, path: 'upcoming');
      final movies = response.data['results']
          .map<MovieModel>((json) => MovieModel.fromJson(json))
          .toList();
      return movies;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<MovieModel>> getSearchedMovie({required String query}) async {
    try {
      final response = await _dioClient.search(query: query);
      final movies = response.data['results']
          .map<MovieModel>((json) => MovieModel.fromJson(json))
          .toList();
      return movies;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetails({required int id}) async {
    try {
      final response = await _dioClient.getDetails(id: id);
      final movies = MovieDetailsModel.fromMap(response.data);

      return movies;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> getImages({required int id}) async {
    try {
      final response = await _dioClient.getImages(id: id);
      final images = response.data['backdrops'];

      return images;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<CastCrewModel>> getCastCrew({required int id}) async {
    try {
      final response = await _dioClient.getcastcrew(id: id);
      final cast = response.data['cast']
          .map<CastCrewModel>((json) => CastCrewModel.fromJson(json))
          .toList();

      return cast;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<VideoModel>> getVideo({required int id}) async {
    try {
      final response = await _dioClient.getvideo(id: id);
      final cast = response.data['results']
          .map<VideoModel>((json) => VideoModel.fromJson(json))
          .toList();

      return cast;
    } catch (_) {
      rethrow;
    }
  }
}

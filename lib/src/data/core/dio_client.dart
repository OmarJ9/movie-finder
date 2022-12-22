import 'package:dio/dio.dart';
import 'package:movie_finder/src/data/core/api_constants.dart';
import 'package:movie_finder/src/data/core/dio_exceptions.dart';

class DioClient {
  late Dio _dio;

  DioClient() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 60 seconds,
      receiveTimeout: 20 * 1000,
    );

    _dio = Dio(options);
  }

  Future<dynamic> get({required int page, required String path}) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/movie/$path',
        queryParameters: {
          'page': page,
          'api_key': ApiConstants.apiKey,
          'sort_by': 'popularity.desc',
        },
      );

      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<dynamic> getDetails({required int id}) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/movie/$id',
        queryParameters: {
          'api_key': ApiConstants.apiKey,
        },
      );

      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<dynamic> getImages({required int id}) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/movie/$id/images',
        queryParameters: {
          'api_key': ApiConstants.apiKey,
        },
      );

      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<dynamic> getcastcrew({required int id}) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/movie/$id/credits',
        queryParameters: {
          'api_key': ApiConstants.apiKey,
        },
      );

      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<dynamic> getvideo({required int id}) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/movie/$id/videos',
        queryParameters: {
          'api_key': ApiConstants.apiKey,
        },
      );

      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<dynamic> search({required String query}) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/search/movie',
        queryParameters: {
          'api_key': ApiConstants.apiKey,
          'query': query,
        },
      );

      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}

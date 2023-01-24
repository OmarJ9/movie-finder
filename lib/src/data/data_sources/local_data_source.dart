import 'dart:convert';
import 'package:hive/hive.dart';

import '../models/movie_model.dart';

const String cachedPopularMovies = 'CACHED_CHARACTERS';
const String cachedTrendingMovies = 'CACHED_EPISODES';
const String cachedUpcomingMovies = 'CACHED_LOCATIONS';
const String hiveBox = 'MY_MOVIE_BOX';

abstract class LocalDataSource {
  Future<void> cache(
      {required String key,
      required List<MovieModel> movies,
      required int page});
  Future<List<MovieModel>> get({required String key, required int page});
}

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<void> cache(
      {required String key,
      required List<MovieModel> movies,
      required int page}) async {
    if (page == 1) {
      final movieBox = await Hive.openBox(hiveBox);
      return movieBox.put(
          key, json.encode(movies.map((e) => e.toJson()).toList()));
    }
  }

  @override
  Future<List<MovieModel>> get({required String key, required int page}) async {
    if (page == 1) {
      final movieBox = await Hive.openBox(hiveBox);
      final cachedmovies = movieBox.get(key);
      if (cachedmovies != null) {
        return json
            .decode(cachedmovies)
            .map<MovieModel>((e) => MovieModel.fromJson(e))
            .toList();
      } else {
        throw 'Empty Cache !!';
      }
    } else {
      return <MovieModel>[];
    }
  }
}

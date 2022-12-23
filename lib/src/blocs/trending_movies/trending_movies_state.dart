import 'package:equatable/equatable.dart';
import 'package:movie_finder/src/data/models/movie_model.dart';

enum TrendingMovieStatus { initial, success, failure }

class TrendingMovieState extends Equatable {
  const TrendingMovieState({
    this.status = TrendingMovieStatus.initial,
    this.trendingMovies = const <MovieModel>[],
    this.hasReachedMax = false,
    this.error = '',
  });

  final TrendingMovieStatus status;
  final List<MovieModel> trendingMovies;
  final bool hasReachedMax;
  final String error;

  TrendingMovieState copyWith({
    TrendingMovieStatus? status,
    List<MovieModel>? trendingMovies,
    bool? hasReachedMax,
    String? error,
  }) {
    return TrendingMovieState(
      status: status ?? this.status,
      trendingMovies: trendingMovies ?? this.trendingMovies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return '''TrendingMovieState { status: $status, hasReachedMax: $hasReachedMax, TrendingMovies: ${trendingMovies.length} }, Error : $error''';
  }

  @override
  List<Object> get props => [status, trendingMovies, hasReachedMax, error];
}

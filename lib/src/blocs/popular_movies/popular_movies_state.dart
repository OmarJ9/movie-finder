import 'package:equatable/equatable.dart';
import 'package:movie_finder/src/data/models/movie_model.dart';

enum PopularMovieStatus { initial, success, failure }

class PopularMovieState extends Equatable {
  const PopularMovieState({
    this.status = PopularMovieStatus.initial,
    this.popularMovies = const <MovieModel>[],
    this.hasReachedMax = false,
    this.error = '',
  });

  final PopularMovieStatus status;
  final List<MovieModel> popularMovies;
  final bool hasReachedMax;
  final String error;

  PopularMovieState copyWith({
    PopularMovieStatus? status,
    List<MovieModel>? popularMovies,
    bool? hasReachedMax,
    String? error,
  }) {
    return PopularMovieState(
      status: status ?? this.status,
      popularMovies: popularMovies ?? this.popularMovies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return '''PopularMovieState { status: $status, hasReachedMax: $hasReachedMax, PopularMovies: ${popularMovies.length} }, Error : $error''';
  }

  @override
  List<Object> get props => [status, popularMovies, hasReachedMax, error];
}

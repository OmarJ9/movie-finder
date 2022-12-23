import 'package:equatable/equatable.dart';
import 'package:movie_finder/src/data/models/movie_model.dart';

enum UpcomingMovieStatus { initial, success, failure }

class UpcomingMovieState extends Equatable {
  const UpcomingMovieState({
    this.status = UpcomingMovieStatus.initial,
    this.upcomingMovies = const <MovieModel>[],
    this.hasReachedMax = false,
    this.error = '',
  });

  final UpcomingMovieStatus status;
  final List<MovieModel> upcomingMovies;
  final bool hasReachedMax;
  final String error;

  UpcomingMovieState copyWith({
    UpcomingMovieStatus? status,
    List<MovieModel>? upcomingMovies,
    bool? hasReachedMax,
    String? error,
  }) {
    return UpcomingMovieState(
      status: status ?? this.status,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return '''UpcomingMovieState { status: $status, hasReachedMax: $hasReachedMax, upcomingMovies: ${upcomingMovies.length} }, Error : $error''';
  }

  @override
  List<Object> get props => [status, upcomingMovies, hasReachedMax, error];
}

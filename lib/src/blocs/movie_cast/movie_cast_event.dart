part of 'movie_cast_bloc.dart';

abstract class MovieCastEvent extends Equatable {
  const MovieCastEvent();

  @override
  List<Object> get props => [];
}

class LoadMovieCast extends MovieCastEvent {
  final int id;

  const LoadMovieCast(this.id);

  @override
  List<Object> get props => [id];
}

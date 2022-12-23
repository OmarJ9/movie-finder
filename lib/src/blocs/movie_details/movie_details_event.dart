part of 'movie_details_bloc.dart';

abstract class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadMovieDetails extends MovieDetailsEvent {
  final int id;

  const LoadMovieDetails(this.id);

  @override
  List<Object> get props => [id];
}

part of 'movie_details_bloc.dart';

abstract class MovieDetailsState extends Equatable {
  const MovieDetailsState();

  @override
  List<Object> get props => [];
}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsSuccess extends MovieDetailsState {
  final MovieDetailsModel movie;

  const MovieDetailsSuccess({required this.movie});

  @override
  List<Object> get props => [movie];
}

class MovieDetailsError extends MovieDetailsState {
  final String error;

  const MovieDetailsError(this.error);

  @override
  List<Object> get props => [error];
}

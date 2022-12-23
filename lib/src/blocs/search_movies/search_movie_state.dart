part of 'search_movie_bloc.dart';

abstract class SearchMovieState extends Equatable {
  const SearchMovieState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchMovieState {}

class SearchLoadingState extends SearchMovieState {}

class SearchSuccessState extends SearchMovieState {
  final List<MovieModel> movies;
  const SearchSuccessState({
    required this.movies,
  });

  @override
  List<Object> get props => [movies];
}

class SearchErrorState extends SearchMovieState {
  final String message;
  const SearchErrorState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

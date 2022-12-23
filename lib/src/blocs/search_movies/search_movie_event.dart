part of 'search_movie_bloc.dart';

abstract class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();

  @override
  List<Object> get props => [];
}

class SearchForMovieEvent extends SearchMovieEvent {
  final String query;

  const SearchForMovieEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class RemoveSearchedEvent extends SearchMovieEvent {
  const RemoveSearchedEvent();
}

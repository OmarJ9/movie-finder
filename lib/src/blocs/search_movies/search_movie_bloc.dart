import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/src/data/models/movie_model.dart';
import 'package:movie_finder/src/data/repositories/movie_repo_impl.dart';
part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final MovieRepository _repo;
  SearchMovieBloc(this._repo) : super(SearchInitial()) {
    on<SearchForMovieEvent>((event, emit) async {
      try {
        emit(SearchLoadingState());
        List<MovieModel> movies =
            await _repo.getSearchedMovie(query: event.query);
        emit(SearchSuccessState(movies: movies));
      } catch (e) {
        emit(SearchErrorState(message: e.toString()));
      }

      on<RemoveSearchedEvent>((event, emit) {
        emit(SearchInitial());
      });
    });
  }
}

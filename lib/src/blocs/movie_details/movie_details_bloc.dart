import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_finder/src/data/models/movie_details_model.dart';
import 'package:movie_finder/src/data/repositories/movie_repo_impl.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MovieRepository _repo;

  MovieDetailsBloc(this._repo) : super(MovieDetailsInitial()) {
    on<LoadMovieDetails>((event, emit) async {
      try {
        emit(MovieDetailsLoading());
        MovieDetailsModel movie = await _repo.getMovieDetails(id: event.id);
        emit(MovieDetailsSuccess(movie: movie));
      } catch (e) {
        emit(MovieDetailsError(e.toString()));
      }
    });
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_finder/src/data/models/cast_model.dart';
import 'package:movie_finder/src/data/repositories/movie_repo_impl.dart';

part 'movie_cast_event.dart';
part 'movie_cast_state.dart';

class MovieCastBloc extends Bloc<MovieCastEvent, MovieCastState> {
  final MovieRepository _repo;

  MovieCastBloc(this._repo) : super(MovieCastInitial()) {
    on<LoadMovieCast>((event, emit) async {
      try {
        emit(MovieCastLoading());
        List<CastCrewModel> cast = await _repo.getCastCrew(id: event.id);
        emit(MovieCastSuccess(cast: cast));
      } catch (e) {
        emit(MovieCastError(e.toString()));
      }
    });
  }
}

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/src/blocs/upcoming_movies/upcoming_movies_event.dart';
import 'package:movie_finder/src/blocs/upcoming_movies/upcoming_movies_state.dart';
import 'package:movie_finder/src/data/repositories/movie_repo_impl.dart';
import 'package:stream_transform/stream_transform.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class UpcomingMovieBloc extends Bloc<UpcomingMovieEvent, UpcomingMovieState> {
  final MovieRepository _repo;
  int page = 1;
  int limit = 3;

  UpcomingMovieBloc(this._repo) : super(const UpcomingMovieState()) {
    on<LoadUpcomingMovieEvent>((event, emit) async {
      if (state.hasReachedMax) return;
      if (state.status == UpcomingMovieStatus.initial) {
        try {
          final movies = await _repo.getUpcoming(page: page);

          page = page + 1;
          return emit(const UpcomingMovieState().copyWith(
            status: UpcomingMovieStatus.success,
            upcomingMovies: movies,
            hasReachedMax: false,
          ));
        } catch (e) {
          return emit(const UpcomingMovieState().copyWith(
            error: e.toString(),
            status: UpcomingMovieStatus.failure,
          ));
        }
      }

      if (page <= limit) {
        try {
          final movies = await _repo.getUpcoming(page: page);
          page = page + 1;
          return emit(const UpcomingMovieState().copyWith(
            status: UpcomingMovieStatus.success,
            upcomingMovies: List.of(state.upcomingMovies)..addAll(movies),
            hasReachedMax: false,
          ));
        } catch (e) {
          return emit(const UpcomingMovieState().copyWith(
            error: e.toString(),
            status: UpcomingMovieStatus.failure,
          ));
        }
      }

      emit(state.copyWith(hasReachedMax: true));
    }, transformer: throttleDroppable(throttleDuration));
  }
}

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/src/data/repositories/movie_repo_impl.dart';
import 'package:stream_transform/stream_transform.dart';
import 'popular_movies_event.dart';
import 'popular_movies_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final MovieRepository _repo;
  int page = 1;
  int limit = 5;

  PopularMovieBloc(this._repo) : super(const PopularMovieState()) {
    on<LoadPopularMovieEvent>(
      (event, emit) async {
        if (state.hasReachedMax) return;
        if (state.status == PopularMovieStatus.initial) {
          try {
            final movies = await _repo.getPopular(page: page);

            page = page + 1;
            return emit(const PopularMovieState().copyWith(
              status: PopularMovieStatus.success,
              popularMovies: movies,
              hasReachedMax: false,
            ));
          } catch (e) {
            return emit(const PopularMovieState().copyWith(
              error: e.toString(),
              status: PopularMovieStatus.failure,
            ));
          }
        }

        if (page <= limit) {
          try {
            final movies = await _repo.getPopular(page: page);
            page = page + 1;
            return emit(const PopularMovieState().copyWith(
              status: PopularMovieStatus.success,
              popularMovies: List.of(state.popularMovies)..addAll(movies),
              hasReachedMax: false,
            ));
          } catch (e) {
            return emit(const PopularMovieState().copyWith(
              error: e.toString(),
              status: PopularMovieStatus.failure,
            ));
          }
        }

        emit(state.copyWith(hasReachedMax: true));
      },
      transformer: throttleDroppable(throttleDuration),
    );
  }
}

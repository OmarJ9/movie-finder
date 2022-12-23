import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/src/blocs/trending_movies/trending_movies_state.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../data/repositories/movie_repo_impl.dart';
import 'trending_movies_event.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class TrendingMovieBloc extends Bloc<TrendingMovieEvent, TrendingMovieState> {
  final MovieRepository _repo;
  int page = 1;
  int limit = 5;

  TrendingMovieBloc(this._repo) : super(const TrendingMovieState()) {
    on<LoadTrendingMovieEvent>(
      (event, emit) async {
        if (state.hasReachedMax) return;
        if (state.status == TrendingMovieStatus.initial) {
          try {
            final movies = await _repo.getTrending(page: page);

            page = page + 1;
            return emit(const TrendingMovieState().copyWith(
              status: TrendingMovieStatus.success,
              trendingMovies: movies,
              hasReachedMax: false,
            ));
          } catch (e) {
            return emit(const TrendingMovieState().copyWith(
              error: e.toString(),
              status: TrendingMovieStatus.failure,
            ));
          }
        }

        if (page <= limit) {
          try {
            final movies = await _repo.getTrending(page: page);
            page = page + 1;
            return emit(const TrendingMovieState().copyWith(
              status: TrendingMovieStatus.success,
              trendingMovies: List.of(state.trendingMovies)..addAll(movies),
              hasReachedMax: false,
            ));
          } catch (e) {
            return emit(const TrendingMovieState().copyWith(
              error: e.toString(),
              status: TrendingMovieStatus.failure,
            ));
          }
        }

        emit(state.copyWith(hasReachedMax: true));
      },
      transformer: throttleDroppable(throttleDuration),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_finder/src/data/repositories/movie_repo_impl.dart';
part 'movie_images_event.dart';
part 'movie_images_state.dart';

class MovieImagesBloc extends Bloc<MovieImagesEvent, MovieImagesState> {
  final MovieRepository _repo;

  MovieImagesBloc(this._repo) : super(MovieImagesInitial()) {
    on<LoadMovieImages>((event, emit) async {
      try {
        emit(MovieImagesLoading());
        List<dynamic> images = await _repo.getImages(id: event.id);
        emit(MovieImagesSuccess(images: images));
      } catch (e) {
        emit(MovieImagesError(e.toString()));
      }
    });
  }
}

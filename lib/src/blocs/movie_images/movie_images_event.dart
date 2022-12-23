part of 'movie_images_bloc.dart';

abstract class MovieImagesEvent extends Equatable {
  const MovieImagesEvent();

  @override
  List<Object> get props => [];
}

class LoadMovieImages extends MovieImagesEvent {
  final int id;

  const LoadMovieImages(this.id);

  @override
  List<Object> get props => [id];
}

part of 'movie_images_bloc.dart';

abstract class MovieImagesState extends Equatable {
  const MovieImagesState();

  @override
  List<Object> get props => [];
}

class MovieImagesInitial extends MovieImagesState {}

class MovieImagesLoading extends MovieImagesState {}

class MovieImagesSuccess extends MovieImagesState {
  final List<dynamic> images;

  const MovieImagesSuccess({required this.images});

  @override
  List<Object> get props => [images];
}

class MovieImagesError extends MovieImagesState {
  final String error;

  const MovieImagesError(this.error);

  @override
  List<Object> get props => [error];
}

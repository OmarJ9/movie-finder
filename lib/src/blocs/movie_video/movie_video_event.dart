part of 'movie_video_bloc.dart';

abstract class MovieVideoEvent extends Equatable {
  const MovieVideoEvent();

  @override
  List<Object> get props => [];
}

class LoadMovieVideo extends MovieVideoEvent {
  final int id;

  const LoadMovieVideo(this.id);

  @override
  List<Object> get props => [id];
}

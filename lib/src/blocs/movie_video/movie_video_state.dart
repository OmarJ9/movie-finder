part of 'movie_video_bloc.dart';

abstract class MovieVideoState extends Equatable {
  const MovieVideoState();

  @override
  List<Object> get props => [];
}

class MovieVideoInitial extends MovieVideoState {}

class MovieVideoLoading extends MovieVideoState {}

class MovieVideoSuccess extends MovieVideoState {
  final List<VideoModel> videos;

  const MovieVideoSuccess({required this.videos});

  @override
  List<Object> get props => [videos];
}

class MovieVideoError extends MovieVideoState {
  final String error;

  const MovieVideoError(this.error);

  @override
  List<Object> get props => [error];
}

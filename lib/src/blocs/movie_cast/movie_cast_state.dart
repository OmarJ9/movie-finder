part of 'movie_cast_bloc.dart';

abstract class MovieCastState extends Equatable {
  const MovieCastState();

  @override
  List<Object> get props => [];
}

class MovieCastInitial extends MovieCastState {}

class MovieCastLoading extends MovieCastState {}

class MovieCastSuccess extends MovieCastState {
  final List<CastCrewModel> cast;

  const MovieCastSuccess({required this.cast});

  @override
  List<Object> get props => [cast];
}

class MovieCastError extends MovieCastState {
  final String error;

  const MovieCastError(this.error);

  @override
  List<Object> get props => [error];
}

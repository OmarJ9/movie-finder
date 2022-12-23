import 'package:equatable/equatable.dart';

abstract class UpcomingMovieEvent extends Equatable {
  const UpcomingMovieEvent();

  @override
  List<Object> get props => [];
}

class LoadUpcomingMovieEvent extends UpcomingMovieEvent {}

part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable {}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthLoadingState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class GoogleAuthLoadingState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthSuccessState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthErrorState extends AuthenticationState {
  final String error;

  AuthErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class UnAuthenticatedState extends AuthenticationState {
  UnAuthenticatedState();
  @override
  List<Object?> get props => [];
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/src/utils/services/auth_service.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService _authservice = AuthService();

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<EmailSignInAuthEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        await _authservice.signInWithEmail(
            email: event.email, password: event.password);
        emit(AuthSuccessState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });

    on<EmailSignUpAuthEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        await _authservice.signUpWithEmail(
            email: event.email, password: event.password);
        emit(AuthSuccessState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });

    on<AnounymousAuthEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        await _authservice.anounymousSignIn();
        emit(AuthSuccessState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });

    on<GoogleAuthEvent>((event, emit) async {
      emit(GoogleAuthLoadingState());
      try {
        await _authservice.signInWithGoogle();
        emit(AuthSuccessState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });

    on<SignOutEvent>((event, emit) async {
      try {
        await _authservice.signOut();

        emit(UnAuthenticatedState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });
  }
}

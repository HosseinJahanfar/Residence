part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthCompletedState extends AuthState {
  final AuthModel authModel;

  AuthCompletedState({required this.authModel});
}

class AuthErrorState extends AuthState {
  final String errorMessage;

  AuthErrorState({required this.errorMessage});
}

///---- logout
class LogOutCompletedState extends AuthState {}

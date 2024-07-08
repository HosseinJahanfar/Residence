part of 'register_residence_user_bloc.dart';

@immutable
sealed class RegisterResidenceUserState {}

final class RegisterResidenceUserInitial extends RegisterResidenceUserState {}

final class RegisterResidenceUserLoadingState
    extends RegisterResidenceUserState {}

final class RegisterResidenceUserCompletedState
    extends RegisterResidenceUserState {
  final List<RegisterResidenceUserModel> registerResidenceUser;

  RegisterResidenceUserCompletedState({required this.registerResidenceUser});
}

final class RegisterResidenceUserError extends RegisterResidenceUserState {
  final String errorMessage;

  RegisterResidenceUserError({required this.errorMessage});
}

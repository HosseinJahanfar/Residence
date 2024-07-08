part of 'residence_registration_bloc.dart';

@immutable
sealed class ResidenceRegistrationState {}

final class ResidenceRegistrationInitial extends ResidenceRegistrationState {}

final class ResidenceRegistrationLoadingState
    extends ResidenceRegistrationState {}

final class ResidenceRegistrationCompletedState
    extends ResidenceRegistrationState {
  final String success;

  ResidenceRegistrationCompletedState({required this.success});
}

final class ResidenceRegistrationErrorState extends ResidenceRegistrationState {
  final String errorMessage;

  ResidenceRegistrationErrorState({required this.errorMessage});
}

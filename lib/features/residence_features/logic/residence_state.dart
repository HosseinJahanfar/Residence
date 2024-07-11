part of 'residence_bloc.dart';

@immutable
sealed class ResidenceState {}

final class ResidenceInitial extends ResidenceState {}

final class ResidenceLoadingState extends ResidenceState {}

final class ResidenceCompletedSate extends ResidenceState {
  final ResidenceDetailModel residenceModel;

  ResidenceCompletedSate({required this.residenceModel});
}

final class ResidenceErrorSate extends ResidenceState {
  final String error;

  ResidenceErrorSate({required this.error});
}


final class ReserveDaysLoading extends ResidenceState {}

final class ReserveDaysCompleted extends ResidenceState {
  final String message;

  ReserveDaysCompleted({required this.message});
}

final class ReserveDaysError extends ResidenceState {
  final String error;

  ReserveDaysError({required this.error});
}

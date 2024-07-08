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

  part of 'residence_reservation_bloc.dart';

  @immutable
  sealed class ResidenceReservationState {}

  final class ResidenceReservationInitial extends ResidenceReservationState {}

  final class ResidenceReservationLoading extends ResidenceReservationState {}

  final class ResidenceReservationCompleted extends ResidenceReservationState {
    final CalculatePriceModel calculatePriceModel;

    ResidenceReservationCompleted({required this.calculatePriceModel});
  }

  final class ResidenceReservationError extends ResidenceReservationState {
    final String error;

    ResidenceReservationError({required this.error});
  }

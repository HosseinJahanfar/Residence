part of 'reservation_bloc.dart';

@immutable
sealed class ReservationState {}

final class ReservationInitial extends ReservationState {}

final class ReservationLoading extends ReservationState {}

final class ReservationCompleted extends ReservationState {
  final ReservationModel reservationModel;

  ReservationCompleted({required this.reservationModel});
}

final class ReservationError extends ReservationState {
  final String errorMessage;

  ReservationError({required this.errorMessage});
}

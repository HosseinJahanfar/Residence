part of 'reservation_bloc.dart';

@immutable
sealed class ReservationEvent {}

final class CallReservationEvent extends ReservationEvent {}

class CancelReservationEvent extends ReservationEvent {
  final int id;

  CancelReservationEvent(this.id);
}

part of 'reservation_bloc.dart';

@immutable
sealed class ReservationEvent {}

final class CallReservationEvent extends ReservationEvent {}

class CancelReservationEvent extends ReservationEvent {
  final String id;

  CancelReservationEvent(this.id);
}

part of 'residence_reservation_bloc.dart';

@immutable
sealed class ResidenceReservationEvent {}

final class CallResidenceReservationEvent extends ResidenceReservationEvent {
  final String dayIds;
  final String numPeople;

  CallResidenceReservationEvent(
      {required this.dayIds, required this.numPeople});
}

part of 'residence_bloc.dart';

@immutable
sealed class ResidenceEvent {}

final class CallResidenceEvent extends ResidenceEvent {
  final String id;

  CallResidenceEvent({required this.id});
}


final class CallReserveDaysEvent extends ResidenceEvent {
  final List<String> daysId;
  final String numPeople;

  CallReserveDaysEvent({required this.daysId, required this.numPeople});
}

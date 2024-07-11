part of 'reserve_days_bloc.dart';

@immutable
sealed class ReserveDaysEvent {}

final class CallReserveDaysEvent extends ReserveDaysEvent {
  final List<String> daysId;
  final String numPeople;

  CallReserveDaysEvent({required this.daysId, required this.numPeople});
}

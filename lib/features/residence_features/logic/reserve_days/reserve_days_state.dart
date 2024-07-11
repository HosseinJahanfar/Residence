part of 'reserve_days_bloc.dart';

@immutable
sealed class ReserveDaysState {}

final class ReserveDaysInitial extends ReserveDaysState {}

final class ReserveDaysLoading extends ReserveDaysState {}

final class ReserveDaysCompleted extends ReserveDaysState {
  final String message;

  ReserveDaysCompleted({required this.message});
}

final class ReserveDaysError extends ReserveDaysState {
  final String error;

  ReserveDaysError({required this.error});
}

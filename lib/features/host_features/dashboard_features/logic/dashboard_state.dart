part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DashboardLoadingState extends DashboardState {}

final class DashboardCompletedState extends DashboardState {
  final HostModel hostModel;

  DashboardCompletedState({required this.hostModel});
}

final class DashboardErrorState extends DashboardState {
  final String errorMessage;

  DashboardErrorState({required this.errorMessage});
}




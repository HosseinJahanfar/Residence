part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

final class CallDashboard extends DashboardEvent {}
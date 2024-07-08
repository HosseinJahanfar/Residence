part of 'residence_list_bloc.dart';

@immutable
sealed class ResidenceListEvent {}

final class CallResidenceListEvent extends ResidenceListEvent {
  final String id;

  CallResidenceListEvent({required this.id});
}

final class CallNextResidenceListEvent extends ResidenceListEvent {
  final String strNextUrl;

  CallNextResidenceListEvent({required this.strNextUrl});
}

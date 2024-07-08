part of 'residence_bloc.dart';

@immutable
sealed class ResidenceEvent {}

final class CallResidenceEvent extends ResidenceEvent {
  final String id;

  CallResidenceEvent({required this.id});
}

part of 'edit_parking_user_bloc.dart';

@immutable
sealed class EditParkingUserEvent {}

final class CallEditParkingUserEvent extends EditParkingUserEvent {
  final String id;

  CallEditParkingUserEvent({required this.id});
}

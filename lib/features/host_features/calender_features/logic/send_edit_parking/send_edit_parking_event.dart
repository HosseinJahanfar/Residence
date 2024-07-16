part of 'send_edit_parking_bloc.dart';

@immutable
sealed class SendEditParkingEvent {}
final class CallSendEditParkingUserEvent extends SendEditParkingEvent {
  final String id;
  final String remainingCapacity;
  final String price;

  CallSendEditParkingUserEvent(
      {required this.id, required this.remainingCapacity, required this.price});
}

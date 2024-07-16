part of 'send_edit_parking_bloc.dart';

@immutable
sealed class SendEditParkingState {}

final class SendEditParkingInitial extends SendEditParkingState {}

final class SendEditParkingUserLoading extends SendEditParkingState {}

final class SendEditParkingUserCompleted extends SendEditParkingState {
  final String msg;

  SendEditParkingUserCompleted({required this.msg});
}

final class SendEditParkingUserError extends SendEditParkingState {
  final String errorMessage;

  SendEditParkingUserError({required this.errorMessage});
}

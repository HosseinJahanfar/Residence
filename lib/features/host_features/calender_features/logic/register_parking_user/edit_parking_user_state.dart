part of 'edit_parking_user_bloc.dart';

@immutable
sealed class EditParkingUserState {}

final class EditParkingUserInitial extends EditParkingUserState {}

///Get
final class EditParkingUserLoading extends EditParkingUserState {}

final class EditParkingUserCompleted extends EditParkingUserState {
  final EditParkingModel editParkingModel;

  EditParkingUserCompleted({required this.editParkingModel});
}

final class EditParkingUserError extends EditParkingUserState {
  final String errorMessage;

  EditParkingUserError({required this.errorMessage});
}

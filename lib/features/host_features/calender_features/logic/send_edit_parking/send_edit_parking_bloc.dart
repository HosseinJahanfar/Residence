import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../../public_features/error/error_exception.dart';
import '../../services/calender_repository.dart';

part 'send_edit_parking_event.dart';

part 'send_edit_parking_state.dart';

class SendEditParkingBloc
    extends Bloc<SendEditParkingEvent, SendEditParkingState> {
  final CalenderRepository _calenderRepository;

  SendEditParkingBloc(this._calenderRepository)
      : super(SendEditParkingInitial()) {
    on<CallSendEditParkingUserEvent>((event, emit) async {
      emit(SendEditParkingUserLoading());
      try {
        String message = await _calenderRepository.editParkingUserRepository(
            event.remainingCapacity, event.price, event.id);
        emit(SendEditParkingUserCompleted(msg: message));
      } on DioException catch (e) {
        emit(SendEditParkingUserError(
            errorMessage: ErrorExceptions().fromError(e).toString()));
      }
    });
  }
}

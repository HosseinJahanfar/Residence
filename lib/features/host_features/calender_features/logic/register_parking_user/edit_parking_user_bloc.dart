import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:meta/meta.dart';

import '../../../../public_features/error/error_exception.dart';
import '../../model/edit_parking_model.dart';
import '../../services/calender_repository.dart';

part 'edit_parking_user_event.dart';

part 'edit_parking_user_state.dart';

class EditParkingUserBloc
    extends Bloc<EditParkingUserEvent, EditParkingUserState> {
  final CalenderRepository _calenderRepository;

  EditParkingUserBloc(this._calenderRepository)
      : super(EditParkingUserInitial()) {
    on<CallEditParkingUserEvent>(_onEditParkingUserEvent);
    //on<CallEditingParkingUserEvent>(_onCallEditingParkingUserEvent);
  }

  FutureOr<void> _onEditParkingUserEvent(CallEditParkingUserEvent event,
      Emitter<EditParkingUserState> emit) async {
    emit(EditParkingUserLoading());

    try {
      EditParkingModel editParkingModel =
          await _calenderRepository.getInfoParkingUserRepository(event.id);
      emit(EditParkingUserCompleted(editParkingModel: editParkingModel));
    } on DioException catch (e) {
      emit(EditParkingUserError(
          errorMessage: ErrorExceptions().fromError(e).toString()));
    }
  }
}

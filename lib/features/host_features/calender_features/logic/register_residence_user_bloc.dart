import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../public_features/error/error_exception.dart';
import '../model/register_parking_user_model.dart';
import '../model/register_residence_user_model.dart';
import '../services/calender_repository.dart';

part 'register_residence_user_event.dart';

part 'register_residence_user_state.dart';

class RegisterResidenceUserBloc
    extends Bloc<RegisterResidenceUserEvent, RegisterResidenceUserState> {
  final CalenderRepository _calenderRepository;

  RegisterResidenceUserBloc(this._calenderRepository)
      : super(RegisterResidenceUserInitial()) {
    on<CallRegisterResidenceUserEvent>(_callRegisterResidenceUserEvent);
    on<CallRegisterParkingUser>(_callCallRegisterParkingUser);
  }

  FutureOr<void> _callRegisterResidenceUserEvent(
      CallRegisterResidenceUserEvent event,
      Emitter<RegisterResidenceUserState> emit) async {
    emit(RegisterResidenceUserLoadingState());

    try {
      List<RegisterResidenceUserModel> registerResidenceUser =
          await _calenderRepository.callRegisterResidenceUser();
      emit(RegisterResidenceUserCompletedState(
          registerResidenceUser: registerResidenceUser));
    } on DioException catch (e) {
      emit(RegisterResidenceUserError(
          errorMessage: ErrorExceptions().fromError(e).toString()));
    }
  }

  FutureOr<void> _callCallRegisterParkingUser(CallRegisterParkingUser event,
      Emitter<RegisterResidenceUserState> emit) async {
    emit(RegisterParkingUserLoading());

    try {
      List<RegisterParkingUserModel> registerParkingUserModel =
          await _calenderRepository.callRegisterParkingUse();
      emit(RegisterParkingUserCompleted(registerParkingUserModel: registerParkingUserModel));
    } on DioException catch (e) {
      emit(RegisterParkingUserError(
          errorMessage: ErrorExceptions().fromError(e).toString()));
    }
  }
}

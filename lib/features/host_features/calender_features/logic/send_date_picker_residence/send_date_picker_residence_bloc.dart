import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:residence/features/host_features/calender_features/model/all_date_model.dart';

import '../../../../public_features/error/error_exception.dart';
import '../../services/calender_repository.dart';

part 'send_date_picker_residence_event.dart';

part 'send_date_picker_residence_state.dart';

class SendDatePickerResidenceBloc
    extends Bloc<SendDatePickerResidenceEvent, SendDatePickerResidenceState> {
  final CalenderRepository _calenderRepository;
  List<AllDateModel> allDateModel = [];
  List<String> result = [];

  SendDatePickerResidenceBloc(this._calenderRepository)
      : super(SendDatePickerResidenceInitial()) {
    on<CallSendDatePickerResidenceEvent>((event, emit) async {
      emit(SendDatePickerResidenceLoadingState());
      try {
        String message =
            await _calenderRepository.callSendDatePickerResidenceRepository(
                event.date,
                event.accommodation,
                event.defaultPrice,
                event.discountPercentage);
        emit(SendDatePickerResidenceCompletedState(success: message));
      } on DioException catch (e) {
        emit(SendDatePickerResidenceErrorState(
            errorMessage: ErrorExceptions().fromError(e).toString()));
      }
    });

    on<CallGetRegisterResidenceUserEvent>((event, emit) async {
      allDateModel.clear();
      result.clear();
      emit(GetRegisterResidenceUserLoading());
      try {
        allDateModel = await _calenderRepository
            .getDatePickerResidenceRepository(event.id);
        for (var element in allDateModel) {
          result.add(element.date.toString());
        }
        emit(GetRegisterResidenceUserCompleted(allDateModel: allDateModel));
      } on DioException catch (e) {
        emit(GetRegisterResidenceUserError(
            errorMessage: ErrorExceptions().fromError(e).toString()));
      }
    });

    on<CallDeleteDatePickerResidenceEvent>((event, emit) async {
      emit(GetRegisterResidenceUserLoading());
      try {
        await _calenderRepository
            .callDeleteDatePickerResidenceRepository(event.id);
        allDateModel.removeAt(event.index);

        emit(GetRegisterResidenceUserCompleted(allDateModel: allDateModel));
      } on DioException catch (e) {
        emit(GetRegisterResidenceUserError(
            errorMessage: ErrorExceptions().fromError(e).toString()));
      }
    });
  }
}

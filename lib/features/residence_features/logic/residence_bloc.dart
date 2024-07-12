import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:residence/features/public_features/error/error_exception.dart';
import '../model/residence_detail_model.dart';
import '../services/residence_repository.dart';

part 'residence_event.dart';

part 'residence_state.dart';

class ResidenceBloc extends Bloc<ResidenceEvent, ResidenceState> {
  final ResidenceDetailRepository _residenceDetailRepository;

  ResidenceBloc(this._residenceDetailRepository) : super(ResidenceInitial()) {
    on<CallResidenceEvent>(_onCallResidenceApi);
    on<CallReserveDaysEvent>(_onCallReserveDaysEvent);
  }

  ResidenceDetailModel residenceDetailModel = ResidenceDetailModel();

  FutureOr<void> _onCallResidenceApi(
      CallResidenceEvent event, Emitter<ResidenceState> emit) async {
    emit(ResidenceLoadingState());

    try {
      residenceDetailModel =
          await _residenceDetailRepository.callDetailProduct(event.id);
      emit(ResidenceCompletedSate(residenceModel: residenceDetailModel));
    } on DioException catch (e) {
      emit(
          ResidenceErrorSate(error: ErrorExceptions().fromError(e).toString()));
    }
  }

  // متدی برای ارسال داده‌های روزهای رزرو و تعداد افراد با متد POST به سرور

  FutureOr<void> _onCallReserveDaysEvent(
      CallReserveDaysEvent event, Emitter<ResidenceState> emit) async {
    emit(ReserveDaysLoading());

    try {
      String message = await _residenceDetailRepository.reserveDaysRepository(
          event.daysId, event.numPeople);

     for(var day in residenceDetailModel.days!){
       if(event.daysId.contains(day.id.toString())){
         day.reservedStatus=true;
       }
     }
      emit(ReserveDaysCompleted(message: message));
      emit(ResidenceCompletedSate(residenceModel: residenceDetailModel));
    } on DioException catch (e) {
      emit(ReserveDaysError(error: ErrorExceptions().fromError(e).toString()));
    }
  }
}

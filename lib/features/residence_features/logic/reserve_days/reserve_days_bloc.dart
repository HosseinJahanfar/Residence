import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:meta/meta.dart';

import '../../../public_features/error/error_exception.dart';
import '../../services/residence_repository.dart';

part 'reserve_days_event.dart';

part 'reserve_days_state.dart';

class ReserveDaysBloc extends Bloc<ReserveDaysEvent, ReserveDaysState> {
  final ResidenceDetailRepository _residenceDetailRepository;

  ReserveDaysBloc(this._residenceDetailRepository)
      : super(ReserveDaysInitial()) {
    on<CallReserveDaysEvent>(_callReserveDaysEvent);
  }

// متدی برای ارسال داده‌های روزهای رزرو و تعداد افراد با متد POST به سرور
  FutureOr<void> _callReserveDaysEvent(
      CallReserveDaysEvent event, Emitter<ReserveDaysState> emit) async {
    emit(ReserveDaysLoading());

    try {
      String message = await _residenceDetailRepository.reserveDaysRepository(
          event.daysId, event.numPeople);
      emit(ReserveDaysCompleted(message: message));
    } on DioException catch (e) {
      emit(ReserveDaysError(error: ErrorExceptions().fromError(e).toString()));
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:residence/features/reservation_features/model/reservation_model.dart';

import '../../public_features/error/error_exception.dart';
import '../services/reservation-repository.dart';

part 'reservation_event.dart';

part 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final ReservationRepository _reservationRepository;

  ReservationBloc(this._reservationRepository) : super(ReservationInitial()) {
    on<CallReservationEvent>(_onCallReservationEvent);
    on<CancelReservationEvent>(_onCancelReservationEvent);
  }

  ReservationModel reservationModel=ReservationModel();
  FutureOr<void> _onCallReservationEvent(CallReservationEvent event,
      Emitter<ReservationState> emit) async {
    emit(ReservationLoading());
    try {
       reservationModel =
      await _reservationRepository.callReservationsRepository();
      emit(ReservationCompleted(reservationModel: reservationModel));
    } on DioException catch (e) {
      emit(ReservationError(errorMessage: ErrorExceptions().fromError(e).toString()));
    }
  }


  FutureOr<void> _onCancelReservationEvent(CancelReservationEvent event,
      Emitter<ReservationState> emit) async {
    emit(ReservationLoading());

    try {
      await _reservationRepository.cancelReservation(event.id);

      reservationModel.currentReservations!
          .removeWhere((element) => element.id.toString() == event.id);

      emit(ReservationCompleted(reservationModel:reservationModel));
    } on DioException catch (e) {
      emit(ReservationError(
          errorMessage: ErrorExceptions().fromError(e).toString()));
    }
  }
}

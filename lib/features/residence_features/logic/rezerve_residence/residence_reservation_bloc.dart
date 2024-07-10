import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../public_features/error/error_exception.dart';
import '../../model/calculate_price_model.dart';
import '../../services/residence_repository.dart';

part 'residence_reservation_event.dart';

part 'residence_reservation_state.dart';

class ResidenceReservationBloc
    extends Bloc<ResidenceReservationEvent, ResidenceReservationState> {
  final ResidenceDetailRepository _residenceDetailRepository;

  ResidenceReservationBloc(this._residenceDetailRepository)
      : super(ResidenceReservationInitial()) {
    on<CallResidenceReservationEvent>((event, emit) async {
      emit(ResidenceReservationLoading());

      try {

        CalculatePriceModel calculatePriceModel =
            await _residenceDetailRepository.calculatePrice(
                event.dayIds, event.numPeople);
        emit(ResidenceReservationCompleted(
            calculatePriceModel: calculatePriceModel));
      } on DioException catch (e) {
        emit(ResidenceReservationError(
            error: ErrorExceptions().fromError(e).toString()));
      }
    });
  }
}

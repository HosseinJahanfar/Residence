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
  }

  FutureOr<void> _onCallResidenceApi(
      CallResidenceEvent event, Emitter<ResidenceState> emit) async {
    emit(ResidenceLoadingState());

    try {
      ResidenceDetailModel residenceDetailModel =
          await _residenceDetailRepository.callDetailProduct(event.id);
      emit(ResidenceCompletedSate(residenceModel: residenceDetailModel));
    } on DioException catch (e) {
      emit(
          ResidenceErrorSate(error: ErrorExceptions().fromError(e).toString()));
    }
  }
}

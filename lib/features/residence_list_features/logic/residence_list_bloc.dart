import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:residence/features/residence_list_features/model/residence_list_model.dart';

import '../../public_features/error/error_exception.dart';
import '../services/residence_list_repository.dart';

part 'residence_list_event.dart';

part 'residence_list_state.dart';

class ResidenceListBloc extends Bloc<ResidenceListEvent, ResidenceListState> {
  final ResidenceListRepository residenceListRepository;
  List<ResidenceListModel> getAllResidenceList = [];

  ResidenceListBloc(this.residenceListRepository)
      : super(ResidenceListInitial()) {
    on<CallResidenceListEvent>(_callResidenceList);
    on<CallNextResidenceListEvent>(_callNextResidenceList);
  }

  FutureOr<void> _callResidenceList(
      CallResidenceListEvent event, Emitter<ResidenceListState> emit) async {
    emit(ResidenceListLoadingState());

    try {
      ResidenceListModel residenceModel =
          await residenceListRepository.callResidenceList(event.id);
      getAllResidenceList.add(residenceModel);
      emit(ResidenceListCompletedSate(residenceListModel: getAllResidenceList));
    } on DioException catch (e) {
      emit(ResidenceListErrorState(
          error: ErrorExceptions().fromError(e).toString()));
    }
  }

  FutureOr<void> _callNextResidenceList(CallNextResidenceListEvent event,
      Emitter<ResidenceListState> emit) async {
    try {
      ResidenceListModel residenceModel =
          await residenceListRepository.callNextListApi(event.strNextUrl);
      getAllResidenceList.add(residenceModel);
      emit(ResidenceListCompletedSate(residenceListModel: getAllResidenceList));
    } on DioException catch (e) {
      emit(ResidenceListErrorState(
          error: ErrorExceptions().fromError(e).toString()));
    }
  }
}

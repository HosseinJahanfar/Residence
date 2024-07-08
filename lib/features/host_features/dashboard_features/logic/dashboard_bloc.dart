import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:residence/features/host_features/dashboard_features/model/host_model.dart';

import '../../../public_features/error/error_exception.dart';
import '../services/dashboard_repository.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository _dashboardRepository;

  DashboardBloc(this._dashboardRepository) : super(DashboardInitial()) {
    on<CallDashboard>(_callDashboard);
  }
///Call TypeHostResidence
  FutureOr<void> _callDashboard(
      CallDashboard event, Emitter<DashboardState> emit) async {
    emit(DashboardLoadingState());

    try {
      HostModel hostModel =
          await _dashboardRepository.callDashboard();
      emit(DashboardCompletedState(hostModel: hostModel));
    } on DioException catch (e) {
      emit(DashboardErrorState(
          errorMessage: ErrorExceptions().fromError(e).toString()));
    }
  }
}


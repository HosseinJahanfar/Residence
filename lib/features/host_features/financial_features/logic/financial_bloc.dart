import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:residence/features/host_features/financial_features/model/financial_model.dart';

import '../../../public_features/error/error_exception.dart';
import '../services/financial_repository.dart';

part 'financial_event.dart';

part 'financial_state.dart';

class FinancialBloc extends Bloc<FinancialEvent, FinancialState> {
  final FinancialRepository _financialRepository;

  FinancialBloc(this._financialRepository) : super(FinancialInitial()) {
    on<CallFinancialEvent>(_onCallFinancialEvent);
    on<CallMoneyEvent>(_onCallMoneyEvent);
  }

  FinancialModel financialModel = FinancialModel();

  FutureOr<void> _onCallFinancialEvent(
      CallFinancialEvent event, Emitter<FinancialState> emit) async {
    emit(FinancialLoading());

    try {
      financialModel = await _financialRepository.callDashboard();
      emit(FinancialCompleted(financialModel: financialModel));
    } on DioException catch (e) {
      emit(FinancialError(
          errorMessage: ErrorExceptions().fromError(e).toString()));
    }
  }

  FutureOr<void> _onCallMoneyEvent(
      CallMoneyEvent event, Emitter<FinancialState> emit) async {
    emit(MoneyLoading());
//    final price = int.tryParse(event.price);

    try {
      // financialModel.balance = financialModel.balance! - price!;
      String msg =
          await _financialRepository.submitPriceRepository(event.price);
      emit(MoneyCompleted(msg: msg));
     // emit(FinancialCompleted(financialModel: financialModel));
    } on DioException catch (e) {
      emit(MoneyError(errorMessage: ErrorExceptions().fromError(e).toString()));
    }
  }
}

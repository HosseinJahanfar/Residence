import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';


import '../../../public_features/error/error_exception.dart';
import '../../model/home_model.dart';
import '../../services/home_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc(this.homeRepository) : super(HomeInitial()) {
    on<CallHomeEvent>(_onCallHomeApi);
  }

  FutureOr<void> _onCallHomeApi(
      CallHomeEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    try {
      HomeModel homeModel = await homeRepository.callIndexApi();

      emit(HomeCompletedState(homeModel: homeModel));
    } on DioException catch (e) {
      emit(HomeErrorState(ErrorExceptions().fromError(e)));
    }
  }
}

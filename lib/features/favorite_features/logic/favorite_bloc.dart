import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:meta/meta.dart';
import 'package:residence/features/favorite_features/model/favorite_model.dart';

import '../../public_features/error/error_exception.dart';
import '../services/favorite_repository.dart';

part 'favorite_event.dart';

part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository favoriteRepository;

  FavoriteBloc(this.favoriteRepository) : super(FavoriteInitial()) {
    on<AddToFavoriteEvent>(_addToFavorite);
    on<CallFavoriteList>(_callFavoriteList);
    on<RemoveFavoriteEvent>(_removeItem);
  }

  FavoriteModel favoriteModel = FavoriteModel();

  FutureOr<void> _addToFavorite(
      AddToFavoriteEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoadingState());

    try {
      final bool status = await favoriteRepository.addToFavorite(event.id);
      emit(FavoriteCompletedState(status: status));
    } on DioException catch (e) {
      emit(FavoriteErrorState(
          errorMessage: ErrorExceptions().fromError(e).toString()));
    }
  }

  FutureOr<void> _callFavoriteList(
      CallFavoriteList event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoadingState());

    try {
      favoriteModel = await favoriteRepository.callFavoriteList();

      emit(FavoriteCompletedListState(favoriteModel));
    } on DioException catch (e) {
      emit(FavoriteErrorState(
          errorMessage: ErrorExceptions().fromError(e).toString()));
    }
  }

  FutureOr<void> _removeItem(
      RemoveFavoriteEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoadingState());

    try {
      await favoriteRepository.removeItemFavorite(event.id);

      favoriteModel.allFavorite!
          .removeWhere((element) => element.id == event.id);

      emit(FavoriteCompletedListState(favoriteModel));
    } on DioException catch (e) {
      emit(FavoriteErrorState(
          errorMessage: ErrorExceptions().fromError(e).toString()));
    }
  }
}

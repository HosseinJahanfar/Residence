part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeCompletedState extends HomeState {
  final HomeModel homeModel;

  HomeCompletedState({required this.homeModel});
}

class HomeErrorState extends HomeState {
  final String? error;

  HomeErrorState(this.error);
}

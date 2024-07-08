part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoadingState extends FavoriteState {}

class FavoriteCompletedState extends FavoriteState {
  final bool status;

  FavoriteCompletedState({required this.status});
}

class FavoriteErrorState extends FavoriteState {
  final String errorMessage;

  FavoriteErrorState({required this.errorMessage});
}

//----- call favorite list
class FavoriteCompletedListState extends FavoriteState {
  final FavoriteModel favoriteModel;

  FavoriteCompletedListState(this.favoriteModel);
}

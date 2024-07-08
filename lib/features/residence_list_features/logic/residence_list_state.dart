part of 'residence_list_bloc.dart';

@immutable
sealed class ResidenceListState {}

final class ResidenceListInitial extends ResidenceListState {}

final class ResidenceListLoadingState extends ResidenceListState {}

final class ResidenceListCompletedSate extends ResidenceListState {
  final List<ResidenceListModel> residenceListModel;

  ResidenceListCompletedSate({required this.residenceListModel});
}

final class ResidenceListErrorState extends ResidenceListState {
  final String error;

  ResidenceListErrorState({required this.error});
}




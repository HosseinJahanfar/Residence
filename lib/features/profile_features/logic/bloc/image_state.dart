part of 'image_bloc.dart';

@immutable
sealed class ProfileImageState {}

final class ProfileImageInitial extends ProfileImageState {}
final class InfoLoadingState extends ProfileImageState {}
final class InfoCompletedState extends ProfileImageState {
  final ProfileModel profileModel;

  InfoCompletedState({required this.profileModel});
}
final class InfoErrorState extends ProfileImageState {
  final String error;

  InfoErrorState({required this.error});
}

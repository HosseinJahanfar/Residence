part of 'image_bloc.dart';

@immutable
sealed class ImageEvent {}

final class InfoSubmitRequest extends ImageEvent {
  final String firstName;
  final String lastName;
  final String fileImg;

  InfoSubmitRequest(
      {required this.firstName, required this.lastName, required this.fileImg});
}

part of 'upload_image_bloc.dart';

@immutable
sealed class UploadImageEvent {}

final class OnSelectMultipleImageEvent extends UploadImageEvent{
  final List<XFile> images;

  OnSelectMultipleImageEvent(this.images);
}


final class OnUnSelectMultipleImageEvent extends UploadImageEvent{
}
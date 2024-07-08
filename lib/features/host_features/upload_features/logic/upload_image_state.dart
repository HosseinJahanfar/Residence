part of 'upload_image_bloc.dart';

@immutable
class UploadImageState {
  final List<XFile>? images;

  const UploadImageState({this.images});

  UploadImageState copywith({List<XFile>? images}) =>
      UploadImageState(images: images ?? this.images);
}
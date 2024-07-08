part of 'image_cubit.dart';

@immutable
sealed class ImageCubitState {}

final class ImageCubitInitial extends ImageCubitState {}

final class ImageLoadedState extends ImageCubitState {
  final String imagePath;
  final int imageSizeInKB;

  ImageLoadedState({
    required this.imagePath,
    required this.imageSizeInKB,
  });
}

final class ImageErrorState extends ImageCubitState {
  final String errorMessage;

  ImageErrorState({required this.errorMessage});
}

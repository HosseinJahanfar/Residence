import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageCubitState> {
  ImageCubit() : super(ImageCubitInitial());

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final pickedImage =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        final File imageFile = File(pickedImage.path);
        final imageSizeInBytes = await imageFile.length();
        final imageSizeInKB = (imageSizeInBytes / 1024).round();
        emit(ImageLoadedState(
          imagePath: pickedImage.path,
          imageSizeInKB: imageSizeInKB,
        ));
      } else {
        emit(ImageErrorState(errorMessage: "عکس انتخاب نشد."));
      }
    } catch (e) {
      emit(ImageErrorState(errorMessage: e.toString()));
    }
  }

  void reset() {
    emit(ImageCubitInitial());
  }
}

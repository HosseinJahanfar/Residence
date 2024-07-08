import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'upload_image_event.dart';

part 'upload_image_state.dart';

class UploadImageBloc extends Bloc<UploadImageEvent, UploadImageState> {
  UploadImageBloc() : super(const UploadImageState()) {
    on<OnSelectMultipleImageEvent>(_onSelectMultipleImages);
    on<OnUnSelectMultipleImageEvent>(_onUnSelectMultipleImageEvent);
  }

  FutureOr<void> _onSelectMultipleImages(
      OnSelectMultipleImageEvent event, Emitter<UploadImageState> emit) async {
    emit(state.copywith(images: event.images));
  }

  FutureOr<void> _onUnSelectMultipleImageEvent(
      OnUnSelectMultipleImageEvent event,
      Emitter<UploadImageState> emit) async {
    emit(state.copywith(images: []));
  }
}

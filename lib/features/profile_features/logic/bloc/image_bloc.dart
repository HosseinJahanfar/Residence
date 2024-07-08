import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:residence/features/profile_features/model/profile_model.dart';

import '../../../public_features/error/error_exception.dart';
import '../../services/profile_repository.dart';

part 'image_event.dart';

part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ProfileImageState> {
  final ProfileRepository _profileRepository;

  ImageBloc(this._profileRepository) : super(ProfileImageInitial()) {
    on<InfoSubmitRequest>(_onInfoSubmitRequest);
  }

  FutureOr<void> _onInfoSubmitRequest(
      InfoSubmitRequest event, Emitter<ProfileImageState> emit) async {
    emit(InfoLoadingState());
    try {
      final firstName = event.firstName;
      final lastName = event.lastName;
      final fileImg = event.fileImg;

      final ProfileModel profileModel = await _profileRepository
          .callProfileRepository(firstName, lastName, fileImg);

      emit(InfoCompletedState(profileModel: profileModel));
    } on DioException catch (e) {
      emit(InfoErrorState(error: ErrorExceptions().fromError(e).toString()));
    }
  }
}

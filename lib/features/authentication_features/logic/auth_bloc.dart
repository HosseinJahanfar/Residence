import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:residence/features/public_features/error/error_exception.dart';

import '../../public_features/functions/secure_storage.dart';
import '../model/auth_model.dart';
import '../services/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<CallAuthEvent>(_callAuth);
    on<CallLogOutEvent>(_callLogOut);
  }

  Future<void> _callAuth(CallAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    try {
      final AuthModel? authModel =
          await authRepository.callAuthApi(event.phoneNumber);

      emit(AuthCompletedState(authModel: authModel!));
    } on DioException catch (e) {
      emit(AuthErrorState(
          errorMessage: ErrorExceptions().fromError(e).toString()));
    }
  }

  Future<void> _callLogOut(
      CallLogOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    try {
      await authRepository.callLogOut();

      await SecureStorageClass().deleteUserToken();

      emit(LogOutCompletedState());
    } on DioException catch (e) {
      emit(AuthErrorState(
          errorMessage: ErrorExceptions().fromError(e).toString()));
    }
  }
}

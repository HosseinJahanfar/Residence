import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../../public_features/error/error_exception.dart';
import '../../services/dashboard_repository.dart';

part 'residence_registration_event.dart';

part 'residence_registration_state.dart';

class ResidenceRegistrationBloc
    extends Bloc<ResidenceRegistrationEvent, ResidenceRegistrationState> {
  final DashboardRepository _dashboardRepository;

  ResidenceRegistrationBloc(this._dashboardRepository)
      : super(ResidenceRegistrationInitial()) {
    on<CallResidenceRegistration>((event, emit) async {
      emit(ResidenceRegistrationLoadingState());

      try {
        await _dashboardRepository.callResidenceRegistrationRepository(
            event.category,
            event.title,
            event.description,
            event.roomCount,
            event.minimumCapacity,
            event.maximumCapacity,
            event.province,
            event.city,
            event.address,
            event.accommodationAbout,
            event.options,
            event.checkInTime,
            event.checkOutTime,
            event.regulations,
            event.lat,
            event.long,
            event.additionalPersonPrice,
            event.imageList);
        emit(ResidenceRegistrationCompletedState(
            success: 'اقامتگاه شما با موفیقت ثبت شد.'));
      } on DioException catch (e) {
        emit(ResidenceRegistrationErrorState(
            errorMessage: ErrorExceptions().fromError(e).toString()));
      }
    });

    on<CallParkingRegistrationEvent>((event, emit) async {
      emit(ResidenceRegistrationLoadingState());

      try {
        await _dashboardRepository.callParkingRegistrationUserRepository(
            event.typeParking,
            event.title,
            event.description,
            event.address,
            event.capacity,
            event.province,
            event.city,
            event.lat,
            event.long,
            event.isCheckingParking,
            event.price,
            event.imageList);
        emit(ResidenceRegistrationCompletedState(
            success: 'پارکینگ شما با موفیقت ثبت شد.'));
      } on DioException catch (e) {
        emit(ResidenceRegistrationErrorState(
            errorMessage: ErrorExceptions().fromError(e).toString()));
      }
    });
  }
}

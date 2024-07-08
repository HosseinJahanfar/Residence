import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:residence/features/host_features/dashboard_features/model/city_model.dart';
import 'package:residence/features/host_features/dashboard_features/model/location_city_model.dart';
import '../../../../public_features/error/error_exception.dart';
import '../../services/dashboard_repository.dart';

part 'city_event.dart';

part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final DashboardRepository _dashboardRepository;

  CityBloc(this._dashboardRepository) : super(CityInitial()) {
    on<CallCityEvent>((event, emit) async {
      emit(CityLoadingState());
      try {
        List<CityModel> cityList =
            await _dashboardRepository.callCity(event.id);
        emit(CityCompletedState(cityList: cityList));
      } on DioException catch (e) {
        emit(CityErrorState(
            errorMessage: ErrorExceptions().fromError(e).toString()));
      } catch (e) {
        emit(CityErrorState(errorMessage: e.toString()));
      }
    });

    on<CallLocationCityEvent>((event, emit) async {
      emit(LocationLoadingState());
      try {
        LocationCityModel locationCityModel =
            await _dashboardRepository.getLocation(event.cityName);
        emit(LocationCompletedState(locationCityModel: locationCityModel));
      } on DioException catch (e) {
        emit(LocationErrorState(
            errorMessage: ErrorExceptions().fromError(e).toString()));
      } catch (e) {
        emit(CityErrorState(errorMessage: e.toString()));
      }
    });
  }
}

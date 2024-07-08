part of 'city_bloc.dart';

@immutable
sealed class CityState {}

/// city drop down
final class CityInitial extends CityState {}

final class CityLoadingState extends CityState {}

final class CityCompletedState extends CityState {
  final List<CityModel> cityList;

  CityCompletedState({required this.cityList});
}

final class CityErrorState extends CityState {
  final String errorMessage;

  CityErrorState({required this.errorMessage});
}

///get lat long location city
final class LocationLoadingState extends CityState {}

final class LocationCompletedState extends CityState {
  final LocationCityModel locationCityModel;

  LocationCompletedState({required this.locationCityModel});
}

final class LocationErrorState extends CityState {
  final String errorMessage;

  LocationErrorState({required this.errorMessage});
}

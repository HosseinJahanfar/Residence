part of 'city_bloc.dart';

@immutable
sealed class CityEvent {}

final class CallCityEvent extends CityEvent {
  final String id;

  CallCityEvent({required this.id});
}

final class CallLocationCityEvent extends CityEvent {
  final String cityName;

  CallLocationCityEvent({required this.cityName});
}

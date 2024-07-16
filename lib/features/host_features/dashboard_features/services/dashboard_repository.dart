import 'package:dio/dio.dart';
import 'package:residence/features/host_features/dashboard_features/model/city_model.dart';
import 'package:residence/features/host_features/dashboard_features/model/location_city_model.dart';
import 'package:residence/features/host_features/dashboard_features/services/dashboard_api_services.dart';

import '../model/host_model.dart';

class DashboardRepository {
  final DashboardApiServices _apiDashboardServices = DashboardApiServices();

  /// call type residence repository
  Future<HostModel> callDashboard() async {
    final Response response = await _apiDashboardServices.callDataDashboard();
    final HostModel favoriteModel = HostModel.fromJson(response.data);
    return favoriteModel;
  }

  //call city repository
  Future<List<CityModel>> callCity(String id) async {
    final Response response = await _apiDashboardServices.callCity(id);

    // فرض کنیم که response.data یک لیست از JSON ها است
    List<dynamic> jsonList = response.data;

    // تبدیل JSON list به List<CityModel>
    List<CityModel> cityList =
        jsonList.map((json) => CityModel.fromJson(json)).toList();
    return cityList;
  }

  /// call lat long city
  Future<LocationCityModel> getLocation(String city) async {
    final Response response = await _apiDashboardServices.getLocation(city);
    final LocationCityModel locationCityModel =
        LocationCityModel.fromJson(response.data);
    return locationCityModel;
  }

  //!callResidenceRegistration host residence Repository
  Future<void> callResidenceRegistrationRepository(
      int category,
      String title,
      String description,
      int roomCount,
      int minimumCapacity,
      int maximumCapacity,
      int province,
      int city,
      String address,
      String accommodationAbout,
      List<int> optionsList,
      String checkInTime,
      String checkOutTime,
      List<int> regulations,
      double lat,
      double long,
      int additionalPersonPrice,
      List<String> imageList) async {
    await _apiDashboardServices.callResidenceRegistration(
        category,
        title,
        description,
        roomCount,
        minimumCapacity,
        maximumCapacity,
        province,
        city,
        address,
        accommodationAbout,
        optionsList,
        checkInTime,
        checkOutTime,
        regulations,
        lat,
        long,
        additionalPersonPrice,
        imageList);
  }

  ///callParkingRegistrationUser host residence
  Future<void> callParkingRegistrationUserRepository(
      String typeParking,
      String title,
      String description,
      String address,
      int capacity,
      int province,
      int city,
      double lat,
      double long,
      bool isCheckingParking,
      int price,
      List<String> imageList) async {
    await _apiDashboardServices.callParkingRegistrationUser(
        typeParking,
        title,
        description,
        address,
        capacity,
        province,
        city,
        lat,
        long,
        isCheckingParking,
        price,
        imageList);
  }
}

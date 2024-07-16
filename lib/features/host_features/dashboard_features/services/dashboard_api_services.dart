import 'package:dio/dio.dart';
import '../../../../const/connection.dart';
import '../../../public_features/functions/secure_storage.dart';

class DashboardApiServices {
  final Dio _dio = Dio();

  /// call type residence
  Future<Response> callDataDashboard() async {
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.sendTimeout = const Duration(seconds: 30);
    final token = await SecureStorageClass().getUserToken();

    // Adding the token to the request headers
    Options options = Options(
      headers: {
        'Authorization': 'Token $token',
      },
    );
    try {
      final Response response =
          await _dio.get('$baseUrl/accommodation/create', options: options);
      // log(response.data.toString());
      return response;
    } catch (error) {
      rethrow; // Throwing error for handling in case of unsuccessful request
    }
  }

  ///call city
  Future<Response> callCity(String id) async {
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.sendTimeout = const Duration(seconds: 30);

    final Response response =
        await _dio.get('$baseUrl/accommodation/province-city-list/$id');
    //log(response.data.toString());
    return response;
  }

  /// call lat long city
  Future<Response> getLocation(String city) async {
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.sendTimeout = const Duration(seconds: 30);
    //final token = await SecureStorageClass().getUserToken();

    // Adding the token to the request headers
    Options options = Options(
      headers: {
        'Api-Key': 'service.9ae4757545dd42a9a92a31628af7e85d',
      },
    );
    try {
      final Response response = await _dio.get(
        'https://api.neshan.org/v1/search',
        options: options,
        queryParameters: {
          'term': city,
          'lat': '53.325',
          'lng': '53.325',
        },
      );
      // log(response.data.toString());
      return response;
    } catch (error) {
      rethrow; // Throwing error for handling in case of unsuccessful request
    }
  }

  ///callResidenceRegistration host residence
  Future<Response> callResidenceRegistration(
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
    List<String> imageList,
  ) async {
    try {
      _dio.options.connectTimeout = const Duration(seconds: 30);
      _dio.options.receiveTimeout = const Duration(seconds: 30);
      _dio.options.sendTimeout = const Duration(seconds: 30);

      final token = await SecureStorageClass().getUserToken();

      // Adding the token to the request headers
      Options options = Options(
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'multipart/form-data',
        },
      );

      // Preparing the form data
      FormData formData = FormData.fromMap({
        'category': category.toString(),
        'title': title,
        'description': description,
        'room_count': roomCount.toString(),
        'minimum_capacity': minimumCapacity.toString(),
        'maximum_capacity': maximumCapacity.toString(),
        'province': province.toString(),
        'city': city.toString(),
        'address': address,
        'accommodation_about': accommodationAbout,
        'options': optionsList.map((e) => e.toString()).toList(),
        'check_in_time': checkInTime,
        'check_out_time': checkOutTime,
        'regulations': regulations.map((e) => e.toString()).toList(),
        'location.latitude': lat.toString(),
        'location.longitude': long.toString(),
        'additional_person_price': additionalPersonPrice.toString(),
      });

      // Adding files to the form data
      for (String imagePath in imageList) {
        formData.files.add(MapEntry(
          'images',
          await MultipartFile.fromFile(imagePath,
              filename: imagePath.split('/').last),
        ));
      }

      final Response response = await _dio.post(
        'http://api.netopen.ir/accommodation/create',
        data: formData,
        options: options,
      );

      return response;
    } catch (e) {
      print('Error calling residence registration API: $e');
      throw e;
    }
  }

  ///callParkingRegistrationUser host residence
  Future<Response> callParkingRegistrationUser(
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
      List<String> imageList,
      ) async {
    try {
      _dio.options.connectTimeout = const Duration(seconds: 30);
      _dio.options.receiveTimeout = const Duration(seconds: 30);
      _dio.options.sendTimeout = const Duration(seconds: 30);

      final token = await SecureStorageClass().getUserToken();

      // Adding the token to the request headers
      Options options = Options(
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'multipart/form-data',
        },
      );

      // Preparing the form data
      FormData formData = FormData.fromMap({
        'parking_type': typeParking,
        'title': title,
        'description': description,
        'address': address,
        'capacity': capacity.toString(),
        'province': province.toString(),
        'city': city.toString(),
        'location.latitude': lat.toString(),
        'location.longitude': long.toString(),
        'car_shade': isCheckingParking.toString(),
        'price': price.toString()
      });

      // Adding files to the form data
      for (String imagePath in imageList) {
        formData.files.add(MapEntry(
          'images',
          await MultipartFile.fromFile(imagePath,
              filename: imagePath.split('/').last),
        ));
      }

      final Response response = await _dio.post(
        '$baseUrl/parking/create',
        data: formData,
        options: options,
      );
      return response;
    } catch (e) {
      print('Error calling residence registration API: $e');
      throw e;
    }
  }
}

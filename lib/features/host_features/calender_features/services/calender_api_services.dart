import 'package:dio/dio.dart';
import '../../../../const/connection.dart';
import '../../../public_features/functions/secure_storage.dart';
import 'dart:developer';

class CalenderApiServices {
  final Dio _dio = Dio();

  /// call List residence register user
  Future<Response> callRegisterResidenceUser() async {
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
      final Response response = await _dio
          .get('$baseUrl/accommodation/user/accommodations', options: options);
      return response;
    } catch (error) {
      rethrow; // Throwing error for handling in case of unsuccessful request
    }
  }

  /// send date picker residence
  Future<Response> callSendDatePickerResidence(String datePicker,
      int accommodation, int defaultPrice, int discountPercentage) async {
    try {
      _dio.options.connectTimeout = const Duration(seconds: 30);
      _dio.options.receiveTimeout = const Duration(seconds: 30);
      _dio.options.sendTimeout = const Duration(seconds: 30);

      final token = await SecureStorageClass().getUserToken();

      // Adding the token to the request headers
      Options options = Options(
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json'
        },
      );

      final Response response = await _dio.post(
        'http://api.netopen.ir/reservation/create-day/',
        data: {
          "date": datePicker,
          "accommodation": accommodation,
          "default_price": defaultPrice,
          "discount_percentage": discountPercentage,
        },
        options: options, // Using the request headers
      );

      return response;
    } catch (e) {
      print('Error calling login token API: $e');
      throw e;
    }
  }

  /// get all date picker residence
  Future<Response> getRegisterResidenceUser(String id) async {
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
          await _dio.get('$baseUrl/reservation/days/$id', options: options);
      return response;
    } catch (error) {
      rethrow; // Throwing error for handling in case of unsuccessful request
    }
  }

  /// delete date picker residence
  Future<Response> deleteDatePickerResidence(String id) async {
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
      final Response response = await _dio.delete(
        'http://api.netopen.ir/reservation/day/$id',
        options: options,
      );
      return response;
    } catch (error) {
      rethrow; // Throwing error for handling in case of unsuccessful request
    }
  }

  ///callCallRegisterParkingUser
  Future<Response> callCallRegisterParkingUser() async {
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
          await _dio.get('$baseUrl/parking/user/parkings', options: options);
      return response;
    } catch (error) {
      rethrow; // Throwing error for handling in case of unsuccessful request
    }
  }

  ///get information parking
  Future<Response> getInfoParkingUser(String id) async {
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
      final Response response = await _dio.get(
          '$baseUrl/reservation/parking-reservations/$id/',
          options: options);
      return response;
    } catch (error) {
      rethrow; // Throwing error for handling in case of unsuccessful request
    }
  }

  ///Edit Parking
  Future<Response> editParkingUser(
      String remainingCapacity, String price,String id) async {
    try {
      _dio.options.connectTimeout = const Duration(seconds: 30);
      _dio.options.receiveTimeout = const Duration(seconds: 30);
      _dio.options.sendTimeout = const Duration(seconds: 30);

      final token = await SecureStorageClass().getUserToken();

      // Adding the token to the request headers
      Options options = Options(
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json'
        },
      );

      final Response response = await _dio.put(
        '$baseUrl/reservation/parking-reservations/$id/',
        data: {
          "remaining_capacity": remainingCapacity,
          "price": price,
        },
        options: options, // Using the request headers
      );
      return response;
    } catch (e) {
      print('Error calling login token API: $e');
      throw e;
    }
  }
}

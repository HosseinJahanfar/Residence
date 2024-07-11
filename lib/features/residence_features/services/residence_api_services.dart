import 'dart:convert';

import 'package:dio/dio.dart';
import '../../../const/connection.dart';
import '../../public_features/functions/secure_storage.dart';
import 'dart:developer';

class ResidenceApiServices {
  final Dio _dio = Dio();

  Future<Response> callDetailResidenceApi(String id) async {
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
          await _dio.get('$baseUrl/accommodation/detail/$id', options: options);
      return response;
    } catch (error) {
      rethrow; // Throwing error for handling in case of unsuccessful request
    }
  }
// متدی برای ارسال داده‌های روزهای رزرو و تعداد افراد با متد POST به سرور
  Future<Response> reserveDays(List<String> dayIds, String numPeople) async {
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.sendTimeout = const Duration(seconds: 30);

    final token = await SecureStorageClass().getUserToken();
    // Define headers
    var headers = {
      'Authorization': 'Token $token',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    // Define data
    var data = {'day_ids': dayIds, 'num_people': numPeople};

    try {
      // Make the POST request
      final Response response = await _dio.request(
        '$baseUrl/reservation/reserve_days/',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      log(response.data.toString());
      return response;
    } catch (error) {
      log('Error in reserveDays: $error');
      rethrow; // Throwing error for handling in case of unsuccessful request
    }
  }
}

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
  /// Calculate price
  Future<Response> calculatePrice(String dayIds, String numPeople) async {
    try {
      _dio.options.connectTimeout = const Duration(seconds: 30);
      _dio.options.receiveTimeout = const Duration(seconds: 30);
      _dio.options.sendTimeout = const Duration(seconds: 30);

      final token = await SecureStorageClass().getUserToken();

      var headers = {
        'Authorization': 'Token $token',
        'Content-Type': 'application/x-www-form-urlencoded',
      };

      var data = 'day_ids=$dayIds&num_people=$numPeople';

      final Response response = await _dio.request(
        'http://api.netopen.ir/reservation/price-calculation/calculate/',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      return response;
    } catch (e) {
      print('Error calling calculate price API: $e');
      throw e;
    }
  }
}

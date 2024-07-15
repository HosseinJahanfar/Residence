import 'package:dio/dio.dart';
import 'dart:developer';
import '../../../../const/connection.dart';
import '../../../public_features/functions/secure_storage.dart';

class FinancialApiServices {
  final Dio _dio = Dio();

  ///Call Api FinancialApi
  Future<Response> callFinancialApi() async {
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
        '$baseUrl/reservation/financial-info/',
        options: options, // Using the request headers
      );
      return response;
    } catch (e) {
      print('Error calling API: $e');
      throw e;
    }
  }

  /// get money
  Future<Response> submitPrice(String price) async {
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
    var data = {'amount': price};

    try {
      // Make the POST request
      final Response response = await _dio.request(
        '$baseUrl/account/withdraw',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      return response;
    } catch (error) {
      log('Error in submitPrice: $error');
      rethrow; // Throwing error for handling in case of unsuccessful request
    }
  }
}

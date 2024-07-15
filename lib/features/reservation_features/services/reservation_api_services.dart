import 'package:dio/dio.dart';

import '../../../const/connection.dart';
import '../../public_features/functions/secure_storage.dart';

class ReservationApiServices {
  final Dio _dio = Dio();

  /// call type residence
  Future<Response> callReservations() async {
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
          .get('$baseUrl/reservation/user-reservations', options: options);
      return response;
    } catch (error) {
      rethrow; // Throwing error for handling in case of unsuccessful request
    }
  }

  ///cancel reservation
  Future<Response> cancelReservation(String id) async {
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
        '$baseUrl/reservation/cancel/$id/',
        options: options, // Using the request hehaders
      );
      return response;
    } catch (error) {
      rethrow; // Throwing error for handling in case of unsuccessful request
    }
  }
}

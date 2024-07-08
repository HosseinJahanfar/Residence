import 'package:dio/dio.dart';

import '../../../const/connection.dart';
import '../../public_features/functions/secure_storage.dart';

class AuthApiService {
  final Dio _dio = Dio();

  /// call authentication api
  Future<Response> callAuthApi(String phoneNumber) async {
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.sendTimeout = const Duration(seconds: 30);
    final Response response = await _dio.post(
      '$baseUrl/account/login',
      queryParameters: {'mobile': phoneNumber},
    );
    return response;
  }

  Future<Response> callLogOut() async {
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.sendTimeout = const Duration(seconds: 30);
    final token = await SecureStorageClass().getUserToken();
    final Response response = await _dio.get('$apiUrl/logout/$token');

    return response;
  }
}

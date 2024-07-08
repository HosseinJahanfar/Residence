import 'package:dio/dio.dart';

import '../../../const/connection.dart';

class ResidenceListApi{
  final Dio _dio=Dio();

  ///callResidenceListApi
  Future<Response> callResidenceListApi(String id) async {
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.sendTimeout = const Duration(seconds: 30);

    final Response response = await _dio.get('$baseUrl/accommodation/city/$id');
    return response;
  }


  ///callResidenceListApi
  Future<Response> callNextPageResidenceListApi(String nextUrl) async {
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.sendTimeout = const Duration(seconds: 30);

    final Response response = await _dio.get(nextUrl);
    return response;
  }
}
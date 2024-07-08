import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio_service;
import '../../../const/connection.dart';
import '../../public_features/functions/secure_storage.dart';
import 'dart:developer';

class CommentAPiServices {
  final Dio _dio = Dio();

  Future<Response> callShowComment(String id) async {
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
          .get('$baseUrl/accommodation/comments/$id', options: options);
      return response;
    } catch (error) {
      rethrow; // Throwing error for handling in case of unsuccessful request
    }
  }

  Future<Response> addComment(String comment, int id) async {
    try {
      _dio.options.connectTimeout = const Duration(seconds: 30);
      _dio.options.receiveTimeout = const Duration(seconds: 30);
      _dio.options.sendTimeout = const Duration(seconds: 30);

      // final token = await SecureStorageClass().getUserToken();
      final token = await SecureStorageClass().getUserToken();
      // Adding the token to the request headers
      Options options = Options(
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'multipart/form-data'
        },
      );

      final Response response = await _dio.post(
        '$baseUrl/accommodation/add_comment',
        data: dio_service.FormData.fromMap(
            {'comment': comment, 'accommodation': id}),
        options: options, // Using the request headers
      );
      return response;
    } catch (e) {
      print('Error calling login token API: $e');
      throw e;
    }
  }
}

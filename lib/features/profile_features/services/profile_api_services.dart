import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../../const/connection.dart';
import '../../public_features/functions/secure_storage.dart';

class ProfileApiServices {
  final Dio _dio = Dio();

  Future<Response> callProfileApi(
      String firstName, String lastName, String pic) async {
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.sendTimeout = const Duration(seconds: 30);
    final token = await SecureStorageClass().getUserToken();
    final headers = {
      'Authorization': 'Token $token',
    };

    const String mimeType =
        'image/jpeg'; // Assume JPEG format for simplicity, you can replace it with dynamic detection

    final data = {
      'first_name': firstName,
      'last_name': lastName,
      'picture': pic == ''
          ? ''
          : await MultipartFile.fromFile(
              pic,
              contentType: MediaType.parse(mimeType),
            ),
    };

    try {
      Response response = await _dio.put('$baseUrl/account/edit_profile',
          data: FormData.fromMap(data), options: Options(headers: headers));
      return response;
    } catch (e) {
      print('Error uploading image: $e');
      throw e;
    }
  }
}

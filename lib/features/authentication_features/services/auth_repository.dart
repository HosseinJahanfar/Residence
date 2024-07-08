import 'package:dio/dio.dart';

import '../model/auth_model.dart';
import 'auth_api_service.dart';

class AuthRepository {
  final AuthApiService _apiService = AuthApiService();

  Future<AuthModel?> callAuthApi(String phoneNumber) async {
    final Response response = await _apiService.callAuthApi(phoneNumber);
    final AuthModel authModel = AuthModel.fromJson(response.data);

    return authModel;
  }

  Future<void> callLogOut() async {
    await _apiService.callLogOut();
  }
}

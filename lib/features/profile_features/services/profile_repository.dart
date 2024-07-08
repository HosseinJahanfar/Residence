import 'package:dio/dio.dart';
import 'package:residence/features/profile_features/services/profile_api_services.dart';

import '../model/profile_model.dart';

class ProfileRepository {
  final ProfileApiServices _profileApiServices = ProfileApiServices();

  ///call profile model
  Future<ProfileModel> callProfileRepository(
      String firstName, String lastName, String pic) async {
    final Response response =
        await _profileApiServices.callProfileApi(firstName, lastName, pic);
    ProfileModel profileModel = ProfileModel.fromJson(response.data);
    return profileModel;
  }
}

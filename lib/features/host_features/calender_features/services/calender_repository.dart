import 'package:dio/dio.dart';
import 'package:residence/features/host_features/calender_features/services/calender_api_services.dart';
import '../model/all_date_model.dart';
import '../model/register_residence_user_model.dart';

class CalenderRepository {
  final CalenderApiServices _calenderApiServices = CalenderApiServices();

  /// call List residence register user repository
  Future<List<RegisterResidenceUserModel>> callRegisterResidenceUser() async {
    try {
      final Response response =
          await _calenderApiServices.callRegisterResidenceUser();
      if (response.statusCode == 200) {
        List<dynamic> jsonList =
            response.data; // فرض: response.data یک لیست از JSON ها است

        List<RegisterResidenceUserModel> registerResidenceUsers = jsonList
            .map((json) => RegisterResidenceUserModel.fromJson(json))
            .toList();

        return registerResidenceUsers;
      } else {
        throw Exception('Failed to load register residence users');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// send date picker residence
  Future<String> callSendDatePickerResidenceRepository(
      String datePicker, int accommodation, int defaultPrice, int discountPercentage) async {
    try {
      Response response = await _calenderApiServices.callSendDatePickerResidence(
          datePicker, accommodation, defaultPrice, discountPercentage);
      if (response.statusCode == 201) {
        return 'تاریخ اضافه شد';
      } else if (response.statusCode == 200) {
        return 'این تاریخ از قبل وجود دارد';
      } else {
        return 'سرور مشکل دارد';
      }
    } catch (e) {
      return 'یک خطای ناشناخته رخ داد: $e';
    }
  }


  /// get all date picker residence
  Future<List<AllDateModel>> getDatePickerResidenceRepository(String id) async {
    try {
      final Response response =
          await _calenderApiServices.getRegisterResidenceUser(id);
      if (response.statusCode == 200) {
        List<dynamic> jsonList =
            response.data; // فرض: response.data یک لیست از JSON ها است

        List<AllDateModel> allDateModel =
            jsonList.map((json) => AllDateModel.fromJson(json)).toList();

        return allDateModel;
      } else {
        throw Exception('Failed to load register residence users');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }



/// delete date picker residence
  Future<void> callDeleteDatePickerResidenceRepository(String id) async {
    await _calenderApiServices.deleteDatePickerResidence(id);
  }

}

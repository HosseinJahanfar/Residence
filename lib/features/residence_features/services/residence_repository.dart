import 'package:dio/dio.dart';
import 'package:residence/features/residence_features/services/residence_api_services.dart';

import '../model/calculate_price_model.dart';
import '../model/residence_detail_model.dart';

class ResidenceDetailRepository {
  final ResidenceApiServices _productApiServices = ResidenceApiServices();

  Future<ResidenceDetailModel> callDetailProduct(String id) async {
    final Response response =
        await _productApiServices.callDetailResidenceApi(id);

    ResidenceDetailModel residenceDetailModel =
        ResidenceDetailModel.fromJson(response.data);
    return residenceDetailModel;
  }

  /// Calculate price
  Future<dynamic> calculatePrice(String dayIds, String numPeople) async {
    try {
      final Response response =
      await _productApiServices.calculatePrice(dayIds, numPeople);

      if (response.statusCode == 200) {
        CalculatePriceModel calculatePriceModel =
        CalculatePriceModel.fromJson(response.data);
        return calculatePriceModel;
      } else if (response.statusCode == 422) {
        return 'تعداد افراد بیشتر از حداکثر ظرفیت است';
      } else {
        return 'خطای سرور: ${response.statusCode}';
      }
    } catch (e) {
      return 'یک خطای ناشناخته رخ داد: $e';
    }
  }
}

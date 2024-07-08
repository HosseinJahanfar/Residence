import 'package:dio/dio.dart';
import 'package:residence/features/residence_features/services/residence_api_services.dart';

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
}

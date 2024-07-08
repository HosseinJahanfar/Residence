import 'package:dio/dio.dart';
import 'package:residence/features/residence_list_features/services/residence_list_api_services.dart';

import '../model/residence_list_model.dart';

class ResidenceListRepository {
  final ResidenceListApi _residenceListApi = ResidenceListApi();

  ///!callResidenceList
  Future<ResidenceListModel> callResidenceList(String id) async {
    final Response response = await _residenceListApi.callResidenceListApi(id);

    ResidenceListModel residence = ResidenceListModel.fromJson(response.data);

    return residence;
  }

  ///!callNextListApi
  Future<ResidenceListModel> callNextListApi(String strURl) async {
    final Response response =
        await _residenceListApi.callNextPageResidenceListApi(strURl);
    ResidenceListModel residence = ResidenceListModel.fromJson(response.data);

    return residence;
  }
}

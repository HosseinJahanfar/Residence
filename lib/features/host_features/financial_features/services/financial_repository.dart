import 'package:dio/dio.dart';
import 'package:residence/features/host_features/financial_features/model/financial_model.dart';
import 'package:residence/features/host_features/financial_features/services/financial_api_services.dart';

class FinancialRepository {
  final FinancialApiServices _financialApiServices = FinancialApiServices();

  ///Call Api FinancialApi
  Future<FinancialModel> callDashboard() async {
    final Response response = await _financialApiServices.callFinancialApi();
    final FinancialModel financialModel =
        FinancialModel.fromJson(response.data);
    return financialModel;
  }
  /// get money
  Future<String> submitPriceRepository(String price) async {
    final Response response =
        await _financialApiServices.submitPrice(price);
   try{
     if (response.statusCode == 201) {
       return 'پول به حساب شما واریز شد';
     } else if (response.statusCode == 200) {
       return 'موجودی کافی نیست';
     } else {
       return 'سرور مشکل دارد';
     }
   }
    catch (e) {
    return 'یک خطای ناشناخته رخ داد: $e';
    }
  }
}

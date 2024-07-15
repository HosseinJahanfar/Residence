import 'package:dio/dio.dart';
import 'package:residence/features/reservation_features/services/reservation_api_services.dart';

import '../model/reservation_model.dart';

class ReservationRepository{


  final ReservationApiServices _reservationApiServices = ReservationApiServices();

  /// call type residence repository
  Future<ReservationModel> callReservationsRepository() async {
    final Response response = await _reservationApiServices.callReservations();
    final ReservationModel reservationModel = ReservationModel.fromJson(response.data);
    return reservationModel;
  }

  ///cancel reservation
  Future<void> cancelReservation(String id) async {
    await _reservationApiServices.cancelReservation(id);
  }
}
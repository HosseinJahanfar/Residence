part of 'residence_registration_bloc.dart';

@immutable
sealed class ResidenceRegistrationEvent {}

final class CallResidenceRegistration extends ResidenceRegistrationEvent {
  final int category;
  final String title;
  final String description;
  final int roomCount;
  final int minimumCapacity;
  final int maximumCapacity;
  final int province;
  final int city;
  final String address;
  final String accommodationAbout;
  final List<int> options;
  final String checkInTime;
  final String checkOutTime;
  final List<int> regulations;
  final double lat;
  final double long;
  final int additionalPersonPrice;
  final List<String> imageList;

  CallResidenceRegistration(
      {required this.category,
      required this.title,
      required this.description,
      required this.roomCount,
      required this.minimumCapacity,
      required this.maximumCapacity,
      required this.province,
      required this.city,
      required this.address,
      required this.accommodationAbout,
      required this.options,
      required this.checkInTime,
      required this.checkOutTime,
      required this.regulations,
      required this.lat,
      required this.long,
      required this.additionalPersonPrice,
      required this.imageList});
}

final class CallParkingRegistrationEvent extends ResidenceRegistrationEvent {
  final String typeParking;
  final String title;
  final String description;
  final String address;
  final int capacity;
  final int province;
  final int city;
  final double lat;
  final double long;
  final bool isCheckingParking;
  final int price;
  final List<String> imageList;

  CallParkingRegistrationEvent(
      {required this.typeParking,
      required this.title,
      required this.description,
      required this.address,
      required this.capacity,
      required this.province,
      required this.city,
      required this.lat,
      required this.long,
      required this.isCheckingParking,
      required this.price,
      required this.imageList});
}

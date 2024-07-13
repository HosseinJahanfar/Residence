class ReservationModel {
  ReservationModel({
      this.currentReservations, 
      this.pastReservations,});

  ReservationModel.fromJson(dynamic json) {
    if (json['current_reservations'] != null) {
      currentReservations = [];
      json['current_reservations'].forEach((v) {
        currentReservations?.add(CurrentReservations.fromJson(v));
      });
    }
    if (json['past_reservations'] != null) {
      pastReservations = [];
      json['past_reservations'].forEach((v) {
        pastReservations?.add(PastReservations.fromJson(v));
      });
    }
  }
  List<CurrentReservations>? currentReservations;
  List<PastReservations>? pastReservations;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (currentReservations != null) {
      map['current_reservations'] = currentReservations?.map((v) => v.toJson()).toList();
    }
    if (pastReservations != null) {
      map['past_reservations'] = pastReservations?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class PastReservations {
  PastReservations({
      this.id, 
      this.accommodationTitle, 
      this.accommodationFirstImage, 
      this.numDays, 
      this.startDate,});

  PastReservations.fromJson(dynamic json) {
    id = json['id'];
    accommodationTitle = json['accommodation_title'];
    accommodationFirstImage = json['accommodation_first_image'];
    numDays = json['num_days'];
    startDate = json['start_date'];
  }
  int? id;
  String? accommodationTitle;
  String? accommodationFirstImage;
  int? numDays;
  String? startDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['accommodation_title'] = accommodationTitle;
    map['accommodation_first_image'] = accommodationFirstImage;
    map['num_days'] = numDays;
    map['start_date'] = startDate;
    return map;
  }

}

class CurrentReservations {
  CurrentReservations({
      this.id, 
      this.accommodationTitle, 
      this.accommodationFirstImage, 
      this.numDays, 
      this.startDate,});

  CurrentReservations.fromJson(dynamic json) {
    id = json['id'];
    accommodationTitle = json['accommodation_title'];
    accommodationFirstImage = json['accommodation_first_image'];
    numDays = json['num_days'];
    startDate = json['start_date'];
  }
  int? id;
  String? accommodationTitle;
  String? accommodationFirstImage;
  int? numDays;
  String? startDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['accommodation_title'] = accommodationTitle;
    map['accommodation_first_image'] = accommodationFirstImage;
    map['num_days'] = numDays;
    map['start_date'] = startDate;
    return map;
  }

}
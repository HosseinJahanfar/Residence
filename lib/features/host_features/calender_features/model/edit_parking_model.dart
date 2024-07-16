class EditParkingModel {
  EditParkingModel({
      this.remainingCapacity, 
      this.price,});

  EditParkingModel.fromJson(dynamic json) {
    remainingCapacity = json['remaining_capacity'];
    price = json['price'];
  }
  int? remainingCapacity;
  int? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remaining_capacity'] = remainingCapacity;
    map['price'] = price;
    return map;
  }

}
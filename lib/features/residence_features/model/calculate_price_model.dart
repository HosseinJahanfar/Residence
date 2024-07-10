class CalculatePriceModel {
  CalculatePriceModel({
      this.maximumPerson, 
      this.totalPrice, 
      this.additionalCount, 
      this.additionalPrice, 
      this.totalDiscount, 
      this.finalPrice,});

  CalculatePriceModel.fromJson(dynamic json) {
    maximumPerson = json['maximum_person'];
    totalPrice = json['total_price'];
    additionalCount = json['additional_count'];
    additionalPrice = json['additional_price'];
    totalDiscount = json['total_discount'];
    finalPrice = json['final_price'];
  }
  int? maximumPerson;
  int? totalPrice;
  int? additionalCount;
  int? additionalPrice;
  int? totalDiscount;
  int? finalPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['maximum_person'] = maximumPerson;
    map['total_price'] = totalPrice;
    map['additional_count'] = additionalCount;
    map['additional_price'] = additionalPrice;
    map['total_discount'] = totalDiscount;
    map['final_price'] = finalPrice;
    return map;
  }

}
class AllDateModel {
  AllDateModel({
      this.id, 
      this.isEditableAndDeletable, 
      this.date, 
      this.defaultPrice, 
      this.discountPercentage, 
      this.percentPrice, 
      this.accommodation,});

  AllDateModel.fromJson(dynamic json) {
    id = json['id'];
    isEditableAndDeletable = json['isEditableAndDeletable'];
    date =(json['date'] as String).replaceAll('-', '/');
    defaultPrice = json['default_price'];
    discountPercentage = json['discount_percentage'];
    percentPrice = json['percent_price'];
    accommodation = json['accommodation'];
  }
  int? id;
  bool? isEditableAndDeletable;
  String? date;
  int? defaultPrice;
  int? discountPercentage;
  int? percentPrice;
  int? accommodation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['isEditableAndDeletable'] = isEditableAndDeletable;
    map['date'] = date;
    map['default_price'] = defaultPrice;
    map['discount_percentage'] = discountPercentage;
    map['percent_price'] = percentPrice;
    map['accommodation'] = accommodation;
    return map;
  }

}
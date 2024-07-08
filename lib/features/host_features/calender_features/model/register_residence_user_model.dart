class RegisterResidenceUserModel {
  RegisterResidenceUserModel({
      this.id, 
      this.image, 
      this.title, 
      this.province, 
      this.city,});

  RegisterResidenceUserModel.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    province = json['province'];
    city = json['city'];
  }
  int? id;
  String? image;
  String? title;
  String? province;
  String? city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['title'] = title;
    map['province'] = province;
    map['city'] = city;
    return map;
  }

}
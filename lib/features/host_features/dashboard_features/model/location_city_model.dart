class LocationCityModel {
  LocationCityModel({
      this.count, 
      this.items,});

  LocationCityModel.fromJson(dynamic json) {
    count = json['count'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }
  int? count;
  List<Items>? items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Items {
  Items({
      this.title, 
      this.address, 
      this.category, 
      this.type, 
      this.region, 
      this.location,});

  Items.fromJson(dynamic json) {
    title = json['title'];
    address = json['address'];
    category = json['category'];
    type = json['type'];
    region = json['region'];
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
  }
  String? title;
  String? address;
  String? category;
  String? type;
  String? region;
  Location? location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['address'] = address;
    map['category'] = category;
    map['type'] = type;
    map['region'] = region;
    if (location != null) {
      map['location'] = location?.toJson();
    }
    return map;
  }

}

class Location {
  Location({
      this.x, 
      this.y, 
      this.z,});

  Location.fromJson(dynamic json) {
    x = json['x'];
    y = json['y'];
    z = json['z'];
  }
  double? x;
  double? y;
  String? z;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['x'] = x;
    map['y'] = y;
    map['z'] = z;
    return map;
  }

}
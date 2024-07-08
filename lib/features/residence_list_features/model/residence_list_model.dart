class ResidenceListModel {
  ResidenceListModel({
      this.count, 
      this.next, 
      this.previous, 
      this.results,});

  ResidenceListModel.fromJson(dynamic json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    results = json['results'] != null ? Results.fromJson(json['results']) : null;
  }
  int? count;
  String? next;
  dynamic previous;
  Results? results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['next'] = next;
    map['previous'] = previous;
    if (results != null) {
      map['results'] = results?.toJson();
    }
    return map;
  }

}

class Results {
  Results({
      this.title, 
      this.accommodations,});

  Results.fromJson(dynamic json) {
    title = json['title'];
    if (json['accommodations'] != null) {
      accommodations = [];
      json['accommodations'].forEach((v) {
        accommodations?.add(Accommodations.fromJson(v));
      });
    }
  }
  String? title;
  List<Accommodations>? accommodations;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    if (accommodations != null) {
      map['accommodations'] = accommodations?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Accommodations {
  Accommodations({
      this.id, 
      this.image, 
      this.title, 
      this.province, 
      this.city, 
      this.roomCount, 
      this.minimumCapacity, 
      this.discountPercentage, 
      this.percentPrice,});

  Accommodations.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    province = json['province'];
    city = json['city'];
    roomCount = json['room_count'];
    minimumCapacity = json['minimum_capacity'];
    discountPercentage = json['discount_percentage'];
    percentPrice = json['percent_price'];
  }
  int? id;
  String? image;
  String? title;
  String? province;
  String? city;
  int? roomCount;
  int? minimumCapacity;
  int? discountPercentage;
  int? percentPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['title'] = title;
    map['province'] = province;
    map['city'] = city;
    map['room_count'] = roomCount;
    map['minimum_capacity'] = minimumCapacity;
    map['discount_percentage'] = discountPercentage;
    map['percent_price'] = percentPrice;
    return map;
  }

}
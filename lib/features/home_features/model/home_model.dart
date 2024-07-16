class HomeModel {
  HomeModel({
      this.sliders, 
      this.southAccommodations, 
      this.popularDestinations, 
      this.suggestionAccommodation, 
      this.northAccommodations, 
      this.pilgrimageAndTouristCities, 
      this.parkingsInBigCities,});

  HomeModel.fromJson(dynamic json) {
    if (json['sliders'] != null) {
      sliders = [];
      json['sliders'].forEach((v) {
        sliders?.add(Sliders.fromJson(v));
      });
    }
    if (json['south_accommodations'] != null) {
      southAccommodations = [];
      json['south_accommodations'].forEach((v) {
        southAccommodations?.add(SouthAccommodations.fromJson(v));
      });
    }
    if (json['popular_destinations'] != null) {
      popularDestinations = [];
      json['popular_destinations'].forEach((v) {
        popularDestinations?.add(PopularDestinations.fromJson(v));
      });
    }
    if (json['suggestion_accommodation'] != null) {
      suggestionAccommodation = [];
      json['suggestion_accommodation'].forEach((v) {
        suggestionAccommodation?.add(SuggestionAccommodation.fromJson(v));
      });
    }
    if (json['north_accommodations'] != null) {
      northAccommodations = [];
      json['north_accommodations'].forEach((v) {
        northAccommodations?.add(NorthAccommodations.fromJson(v));
      });
    }
    if (json['Pilgrimage_and_tourist_cities'] != null) {
      pilgrimageAndTouristCities = [];
      json['Pilgrimage_and_tourist_cities'].forEach((v) {
        pilgrimageAndTouristCities?.add(PilgrimageAndTouristCities.fromJson(v));
      });
    }
    if (json['parkings_in_big_cities'] != null) {
      parkingsInBigCities = [];
      json['parkings_in_big_cities'].forEach((v) {
        parkingsInBigCities?.add(ParkingsInBigCities.fromJson(v));
      });
    }
  }
  List<Sliders>? sliders;
  List<SouthAccommodations>? southAccommodations;
  List<PopularDestinations>? popularDestinations;
  List<SuggestionAccommodation>? suggestionAccommodation;
  List<NorthAccommodations>? northAccommodations;
  List<PilgrimageAndTouristCities>? pilgrimageAndTouristCities;
  List<ParkingsInBigCities>? parkingsInBigCities;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (sliders != null) {
      map['sliders'] = sliders?.map((v) => v.toJson()).toList();
    }
    if (southAccommodations != null) {
      map['south_accommodations'] = southAccommodations?.map((v) => v.toJson()).toList();
    }
    if (popularDestinations != null) {
      map['popular_destinations'] = popularDestinations?.map((v) => v.toJson()).toList();
    }
    if (suggestionAccommodation != null) {
      map['suggestion_accommodation'] = suggestionAccommodation?.map((v) => v.toJson()).toList();
    }
    if (northAccommodations != null) {
      map['north_accommodations'] = northAccommodations?.map((v) => v.toJson()).toList();
    }
    if (pilgrimageAndTouristCities != null) {
      map['Pilgrimage_and_tourist_cities'] = pilgrimageAndTouristCities?.map((v) => v.toJson()).toList();
    }
    if (parkingsInBigCities != null) {
      map['parkings_in_big_cities'] = parkingsInBigCities?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ParkingsInBigCities {
  ParkingsInBigCities({
      this.id, 
      this.title, 
      this.image, 
      this.city, 
      this.province, 
      this.parkingType, 
      this.remainingCapacity, 
      this.price,});

  ParkingsInBigCities.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    city = json['city'];
    province = json['province'];
    parkingType = json['parking_type'];
    remainingCapacity = json['remaining_capacity'];
    price = json['price'];
  }
  int? id;
  String? title;
  String? image;
  String? city;
  String? province;
  String? parkingType;
  int? remainingCapacity;
  int? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['image'] = image;
    map['city'] = city;
    map['province'] = province;
    map['parking_type'] = parkingType;
    map['remaining_capacity'] = remainingCapacity;
    map['price'] = price;
    return map;
  }

}

class PilgrimageAndTouristCities {
  PilgrimageAndTouristCities({
      this.id, 
      this.name, 
      this.province, 
      this.picture,});

  PilgrimageAndTouristCities.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    province = json['province'];
    picture = json['picture'];
  }
  int? id;
  String? name;
  String? province;
  String? picture;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['province'] = province;
    map['picture'] = picture;
    return map;
  }

}

class NorthAccommodations {
  NorthAccommodations({
      this.id, 
      this.name, 
      this.province, 
      this.picture,});

  NorthAccommodations.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    province = json['province'];
    picture = json['picture'];
  }
  int? id;
  String? name;
  String? province;
  String? picture;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['province'] = province;
    map['picture'] = picture;
    return map;
  }

}

class SuggestionAccommodation {
  SuggestionAccommodation({
      this.id, 
      this.title, 
      this.maximumCapacity, 
      this.image, 
      this.city, 
      this.province, 
      this.defaultPrice, 
      this.discountPercentage, 
      this.percentPrice,});

  SuggestionAccommodation.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    maximumCapacity = json['maximum_capacity'];
    image = json['image'];
    city = json['city'];
    province = json['province'];
    defaultPrice = json['default_price'];
    discountPercentage = json['discount_percentage'];
    percentPrice = json['percent_price'];
  }
  int? id;
  String? title;
  int? maximumCapacity;
  String? image;
  String? city;
  String? province;
  int? defaultPrice;
  int? discountPercentage;
  int? percentPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['maximum_capacity'] = maximumCapacity;
    map['image'] = image;
    map['city'] = city;
    map['province'] = province;
    map['default_price'] = defaultPrice;
    map['discount_percentage'] = discountPercentage;
    map['percent_price'] = percentPrice;
    return map;
  }

}

class PopularDestinations {
  PopularDestinations({
      this.id, 
      this.name, 
      this.province, 
      this.picture,});

  PopularDestinations.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    province = json['province'];
    picture = json['picture'];
  }
  int? id;
  String? name;
  String? province;
  String? picture;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['province'] = province;
    map['picture'] = picture;
    return map;
  }

}

class SouthAccommodations {
  SouthAccommodations({
      this.id, 
      this.name, 
      this.province, 
      this.picture,});

  SouthAccommodations.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    province = json['province'];
    picture = json['picture'];
  }
  int? id;
  String? name;
  String? province;
  String? picture;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['province'] = province;
    map['picture'] = picture;
    return map;
  }

}

class Sliders {
  Sliders({
      this.id, 
      this.link, 
      this.image, 
      this.type,});

  Sliders.fromJson(dynamic json) {
    id = json['id'];
    link = json['link'];
    image = json['image'];
    type = json['type'];
  }
  int? id;
  String? link;
  String? image;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['link'] = link;
    map['image'] = image;
    map['type'] = type;
    return map;
  }

}
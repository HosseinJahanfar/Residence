class ResidenceDetailModel {
  ResidenceDetailModel({
    this.id,
    this.category,
    this.city,
    this.image,
    this.province,
    this.options,
    this.user,
    this.location,
    this.fav,
    this.defaultPrice,
    this.discountPercentage,
    this.percentPrice,
    this.totalComments,
    this.comments,
    this.days,
    this.regulations,
    this.checkInTime,
    this.checkOutTime,
    this.title,
    this.description,
    this.address,
    this.roomCount,
    this.minimumCapacity,
    this.maximumCapacity,
    this.accommodationAbout,
    this.additionalPersonPrice,
  });

  ResidenceDetailModel.fromJson(dynamic json) {
    id = json['id'];
    category = json['category'];
    city = json['city'];
    image = json['image'] != null ? json['image'].cast<String>() : [];
    province = json['province'];
    if (json['options'] != null) {
      options = [];
      json['options'].forEach((v) {
        options?.add(Options.fromJson(v));
      });
    }
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    fav = json['fav'];
    defaultPrice = json['default_price'] is double ? (json['default_price'] as double).toInt() : json['default_price'];
    discountPercentage = json['discount_percentage'];
    percentPrice = json['percent_price'] is double ? (json['percent_price'] as double).toInt() : json['percent_price'];
    totalComments = json['total_comments'];
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments?.add(Comments.fromJson(v));
      });
    }
    if (json['days'] != null) {
      days = [];
      json['days'].forEach((v) {
        days?.add(Days.fromJson(v));
      });
    }
    if (json['regulations'] != null) {
      regulations = [];
      json['regulations'].forEach((v) {
        regulations?.add(Regulations.fromJson(v));
      });
    }
    checkInTime = json['check_in_time'];
    checkOutTime = json['check_out_time'];
    title = json['title'];
    description = json['description'];
    address = json['address'];
    roomCount = json['room_count'];
    minimumCapacity = json['minimum_capacity'];
    maximumCapacity = json['maximum_capacity'];
    accommodationAbout = json['accommodation_about'];
    additionalPersonPrice = json['additional_person_price'];
  }

  int? id;
  String? category;
  String? city;
  List<String>? image;
  String? province;
  List<Options>? options;
  User? user;
  Location? location;
  bool? fav;
  int? defaultPrice;
  int? discountPercentage;
  int? percentPrice;
  int? totalComments;
  List<Comments>? comments;
  List<Days>? days;
  List<Regulations>? regulations;
  String? checkInTime;
  String? checkOutTime;
  String? title;
  String? description;
  String? address;
  int? roomCount;
  int? minimumCapacity;
  int? maximumCapacity;
  String? accommodationAbout;
  int? additionalPersonPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['category'] = category;
    map['city'] = city;
    map['image'] = image;
    map['province'] = province;
    if (options != null) {
      map['options'] = options?.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['fav'] = fav;
    map['default_price'] = defaultPrice;
    map['discount_percentage'] = discountPercentage;
    map['percent_price'] = percentPrice;
    map['total_comments'] = totalComments;
    if (comments != null) {
      map['comments'] = comments?.map((v) => v.toJson()).toList();
    }
    if (days != null) {
      map['days'] = days?.map((v) => v.toJson()).toList();
    }
    if (regulations != null) {
      map['regulations'] = regulations?.map((v) => v.toJson()).toList();
    }
    map['check_in_time'] = checkInTime;
    map['check_out_time'] = checkOutTime;
    map['title'] = title;
    map['description'] = description;
    map['address'] = address;
    map['room_count'] = roomCount;
    map['minimum_capacity'] = minimumCapacity;
    map['maximum_capacity'] = maximumCapacity;
    map['accommodation_about'] = accommodationAbout;
    map['additional_person_price'] = additionalPersonPrice;
    return map;
  }
}

class Regulations {
  Regulations({
    this.name,
    this.isAllowed,
  });

  Regulations.fromJson(dynamic json) {
    name = json['name'];
    isAllowed = json['is_allowed'];
  }

  String? name;
  bool? isAllowed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['is_allowed'] = isAllowed;
    return map;
  }
}

class Days {
  Days({
    this.id,
    this.date,
    this.defaultPrice,
    this.discountPercentage,
    this.percentPrice,
    this.reservedStatus,
  });

  Days.fromJson(dynamic json) {
    id = json['id'];
    date = (json['date'] as String).replaceAll('-', '/');
    defaultPrice = json['default_price'] is double ? (json['default_price'] as double).toInt() : json['default_price'];
    discountPercentage = json['discount_percentage'];
    percentPrice = json['percent_price'] is double ? (json['percent_price'] as double).toInt() : json['percent_price'];
    reservedStatus = json['reserved_status'];
  }

  int? id;
  String? date;
  int? defaultPrice;
  int? discountPercentage;
  int? percentPrice;
  bool? reservedStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['date'] = date;
    map['default_price'] = defaultPrice;
    map['discount_percentage'] = discountPercentage;
    map['percent_price'] = percentPrice;
    map['reserved_status'] = reservedStatus;
    return map;
  }
}

class Comments {
  Comments({
    this.fullname,
    this.comment,
    this.timeSinceCreated,
  });

  Comments.fromJson(dynamic json) {
    fullname = json['fullname'];
    comment = json['comment'];
    timeSinceCreated = json['time_since_created'];
  }

  String? fullname;
  String? comment;
  String? timeSinceCreated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullname'] = fullname;
    map['comment'] = comment;
    map['time_since_created'] = timeSinceCreated;
    return map;
  }
}

class Location {
  Location({
    this.latitude,
    this.longitude,
  });

  Location.fromJson(dynamic json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  double? latitude;
  double? longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    return map;
  }
}

class User {
  User({
    this.firstName,
    this.lastName,
    this.picture,
  });

  User.fromJson(dynamic json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    picture = json['picture'];
  }

  String? firstName;
  String? lastName;
  String? picture;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['picture'] = picture;
    return map;
  }
}

class Options {
  Options({
    this.id,
    this.name,
    this.icon,
  });

  Options.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
  }

  int? id;
  String? name;
  String? icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['icon'] = icon;
    return map;
  }
}

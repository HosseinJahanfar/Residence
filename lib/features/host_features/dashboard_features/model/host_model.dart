class HostModel {
  HostModel({
      this.categories, 
      this.options, 
      this.provinces, 
      this.regulations,});

  HostModel.fromJson(dynamic json) {
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
    if (json['options'] != null) {
      options = [];
      json['options'].forEach((v) {
        options?.add(Options.fromJson(v));
      });
    }
    if (json['provinces'] != null) {
      provinces = [];
      json['provinces'].forEach((v) {
        provinces?.add(Provinces.fromJson(v));
      });
    }
    if (json['regulations'] != null) {
      regulations = [];
      json['regulations'].forEach((v) {
        regulations?.add(Regulations.fromJson(v));
      });
    }
  }
  List<Categories>? categories;
  List<Options>? options;
  List<Provinces>? provinces;
  List<Regulations>? regulations;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    if (options != null) {
      map['options'] = options?.map((v) => v.toJson()).toList();
    }
    if (provinces != null) {
      map['provinces'] = provinces?.map((v) => v.toJson()).toList();
    }
    if (regulations != null) {
      map['regulations'] = regulations?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Regulations {
  Regulations({
      this.id, 
      this.name,});

  Regulations.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}

class Provinces {
  Provinces({
      this.id, 
      this.name,});

  Provinces.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}

class Options {
  Options({
      this.id, 
      this.name, 
      this.icon,});

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

class Categories {
  Categories({
      this.id, 
      this.title, 
      this.picture,});

  Categories.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    picture = json['picture'];
  }
  int? id;
  String? title;
  String? picture;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['picture'] = picture;
    return map;
  }

}
class FavoriteModel {
  FavoriteModel({
      this.allFavorite,});

  FavoriteModel.fromJson(dynamic json) {
    if (json['all_favorite'] != null) {
      allFavorite = [];
      json['all_favorite'].forEach((v) {
        allFavorite?.add(AllFavorite.fromJson(v));
      });
    }
  }
  List<AllFavorite>? allFavorite;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (allFavorite != null) {
      map['all_favorite'] = allFavorite?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class AllFavorite {
  AllFavorite({
      this.id, 
      this.title, 
      this.image, 
      this.defaultPrice, 
      this.discountPercentage, 
      this.percentPrice,});

  AllFavorite.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    defaultPrice = json['default_price'];
    discountPercentage = json['discount_percentage'];
    percentPrice = json['percent_price'];
  }
  int? id;
  String? title;
  String? image;
  int? defaultPrice;
  int? discountPercentage;
  int? percentPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['image'] = image;
    map['default_price'] = defaultPrice;
    map['discount_percentage'] = discountPercentage;
    map['percent_price'] = percentPrice;
    return map;
  }

}
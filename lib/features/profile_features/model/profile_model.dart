class ProfileModel {
  String? firstName;
  String? lastName;
  String? picture;

  ProfileModel({
    this.firstName,
    this.lastName,
    this.picture,
  });

  ProfileModel.fromJson(dynamic json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    picture = json['picture'];
  }
}

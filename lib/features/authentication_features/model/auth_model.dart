class AuthModel {
  bool? profileAvailable;
  String? msg;
  String? access;

  AuthModel({
    this.profileAvailable,
    this.msg,
    this.access,
  });

  AuthModel.fromJson(dynamic json) {
    profileAvailable = json['profile_available'];
    msg = json['msg'];
    access = json['access'];
  }
}

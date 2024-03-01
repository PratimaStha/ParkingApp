// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  UserProfile? userProfile;

  LoginResponseModel({
    this.userProfile,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        userProfile: json["userProfile"] == null
            ? null
            : UserProfile.fromJson(json["userProfile"]),
      );

  Map<String, dynamic> toJson() => {
        "userProfile": userProfile?.toJson(),
      };
}

class UserProfile {
  String? id;
  String? name;
  String? email;
  bool? isComplete;
  String? jobType;
  bool? emailIsVerified;
  String? accessToken;
  String? refreshToken;
  bool? isLogin;

  UserProfile({
    this.id,
    this.name,
    this.email,
    this.isComplete,
    this.jobType,
    this.emailIsVerified,
    this.accessToken,
    this.refreshToken,
    this.isLogin,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        isComplete: json["isComplete"],
        jobType: json["jobType"],
        emailIsVerified: json["emailIsVerified"],
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        isLogin: json["isLogin"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "isComplete": isComplete,
        "jobType": jobType,
        "emailIsVerified": emailIsVerified,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "isLogin": isLogin,
      };
}

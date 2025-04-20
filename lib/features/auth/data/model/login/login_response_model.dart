// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  String? status;
  String? token;
  User? user;

  LoginResponseModel({
    this.status,
    this.token,
    this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    status: json["status"],
    token: json["token"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "token": token,
    "user": user?.toJson(),
  };
}

class User {
  String? email;
  String? id;
  int? creditsRemaining;
  String? subscriptionTier;

  User({
    this.email,
    this.id,
    this.creditsRemaining,
    this.subscriptionTier,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    email: json["email"],
    id: json["id"],
    creditsRemaining: json["credits_remaining"],
    subscriptionTier: json["subscription_tier"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "id": id,
    "credits_remaining": creditsRemaining,
    "subscription_tier": subscriptionTier,
  };
}
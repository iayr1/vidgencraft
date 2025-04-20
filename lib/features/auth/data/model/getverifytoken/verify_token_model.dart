// To parse this JSON data, do
//
//     final verifyResponseModel = verifyResponseModelFromJson(jsonString);

import 'dart:convert';

VerifyResponseModel verifyResponseModelFromJson(String str) => VerifyResponseModel.fromJson(json.decode(str));

String verifyResponseModelToJson(VerifyResponseModel data) => json.encode(data.toJson());

class VerifyResponseModel {
  bool? valid;
  User? user;

  VerifyResponseModel({
    this.valid,
    this.user,
  });

  factory VerifyResponseModel.fromJson(Map<String, dynamic> json) => VerifyResponseModel(
    valid: json["valid"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "valid": valid,
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

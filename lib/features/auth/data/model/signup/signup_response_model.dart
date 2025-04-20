// To parse this JSON data, do
//
//     final signUpResponseModel = signUpResponseModelFromJson(jsonString);

import 'dart:convert';

SignUpResponseModel signUpResponseModelFromJson(String str) => SignUpResponseModel.fromJson(json.decode(str));

String signUpResponseModelToJson(SignUpResponseModel data) => json.encode(data.toJson());

class SignUpResponseModel {
  String? status;
  String? message;
  String? userId;

  SignUpResponseModel({
    this.status,
    this.message,
    this.userId,
  });

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) => SignUpResponseModel(
    status: json["status"],
    message: json["message"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "user_id": userId,
  };
}

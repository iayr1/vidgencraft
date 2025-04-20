// To parse this JSON data, do
//
//     final signUpRequestModel = signUpRequestModelFromJson(jsonString);

import 'dart:convert';

SignUpRequestModel signUpRequestModelFromJson(String str) => SignUpRequestModel.fromJson(json.decode(str));

String signUpRequestModelToJson(SignUpRequestModel data) => json.encode(data.toJson());

class SignUpRequestModel {
  String? email;
  String? password;
  String? confirmPassword;

  SignUpRequestModel({
    this.email,
    this.password,
    this.confirmPassword,
  });

  factory SignUpRequestModel.fromJson(Map<String, dynamic> json) => SignUpRequestModel(
    email: json["email"],
    password: json["password"],
    confirmPassword: json["confirm_password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "confirm_password": confirmPassword,
  };
}
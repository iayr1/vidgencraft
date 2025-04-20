// To parse this JSON data, do
//
//     final resetPasswordRequestModel = resetPasswordRequestModelFromJson(jsonString);

import 'dart:convert';

ResetPasswordRequestModel resetPasswordRequestModelFromJson(String str) => ResetPasswordRequestModel.fromJson(json.decode(str));

String resetPasswordRequestModelToJson(ResetPasswordRequestModel data) => json.encode(data.toJson());

class ResetPasswordRequestModel {
  String? email;

  ResetPasswordRequestModel({
    this.email,
  });

  factory ResetPasswordRequestModel.fromJson(Map<String, dynamic> json) => ResetPasswordRequestModel(
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
  };
}

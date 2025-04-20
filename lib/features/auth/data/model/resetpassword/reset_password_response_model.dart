// To parse this JSON data, do
//
//     final resetPasswordResponseModel = resetPasswordResponseModelFromJson(jsonString);

import 'dart:convert';

ResetPasswordResponseModel resetPasswordResponseModelFromJson(String str) => ResetPasswordResponseModel.fromJson(json.decode(str));

String resetPasswordResponseModelToJson(ResetPasswordResponseModel data) => json.encode(data.toJson());

class ResetPasswordResponseModel {
  String? status;
  String? message;

  ResetPasswordResponseModel({
    this.status,
    this.message,
  });

  factory ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) => ResetPasswordResponseModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}

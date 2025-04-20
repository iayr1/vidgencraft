// To parse this JSON data, do
//
//     final verifyOtpRequestModel = verifyOtpRequestModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpRequestModel verifyOtpRequestModelFromJson(String str) => VerifyOtpRequestModel.fromJson(json.decode(str));

String verifyOtpRequestModelToJson(VerifyOtpRequestModel data) => json.encode(data.toJson());

class VerifyOtpRequestModel {
  String? status;
  String? message;
  String? resetToken;

  VerifyOtpRequestModel({
    this.status,
    this.message,
    this.resetToken,
  });

  factory VerifyOtpRequestModel.fromJson(Map<String, dynamic> json) => VerifyOtpRequestModel(
    status: json["status"],
    message: json["message"],
    resetToken: json["reset_token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "reset_token": resetToken,
  };
}

// To parse this JSON data, do
//
//     final verifyOtpRequestModel = verifyOtpRequestModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpResponseModel verifyOtpResponseModelFromJson(String str) => VerifyOtpResponseModel.fromJson(json.decode(str));

String verifyOtpResponseModelToJson(VerifyOtpResponseModel data) => json.encode(data.toJson());

class VerifyOtpResponseModel {
  String? status;
  String? message;
  String? resetToken;

  VerifyOtpResponseModel({
    this.status,
    this.message,
    this.resetToken,
  });

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) => VerifyOtpResponseModel(
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

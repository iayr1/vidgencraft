import '../entities/user_entity.dart';
import 'dart:convert';

class UserDataModel extends UserEntity {
  const UserDataModel({
    String? id,
    String? name,
    String? email,
    String? password,
    int? creditsRemaining,
    String? subscriptionTier,
    String? token,
  }) : super(
    id: id,
    name: name,
    email: email,
    password: password,
    creditsRemaining: creditsRemaining,
    subscriptionTier: subscriptionTier,
    token: token,
  );

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      creditsRemaining: json['creditsRemaining'],
      subscriptionTier: json['subscriptionTier'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'password': password,
    'creditsRemaining': creditsRemaining,
    'subscriptionTier': subscriptionTier,
    'token': token,
  };

  factory UserDataModel.fromEntity(UserEntity entity) {
    return UserDataModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      password: entity.password,
      creditsRemaining: entity.creditsRemaining,
      subscriptionTier: entity.subscriptionTier,
      token: entity.token,
    );
  }

  String toRawJson() => json.encode(toJson());

  factory UserDataModel.fromRawJson(String str) =>
      UserDataModel.fromJson(json.decode(str));
}

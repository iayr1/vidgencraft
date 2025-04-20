import 'dart:convert';

import '../models/user_data_model.dart';
import '../entities/user_entity.dart';
import '../services/secure_storage_service.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final SecureStorageService secureStorage;

  UserRepositoryImpl(this.secureStorage);

  @override
  Future<void> cacheUser(UserEntity user) async {
    final model = UserDataModel.fromEntity(user);
    await secureStorage.saveUser(model.toRawJson());
  }

  @override
  Future<UserEntity?> getCachedUser() async {
    final data = await secureStorage.getUser();
    if (data == null) return null;
    return UserDataModel.fromRawJson(data);
  }

  @override
  Future<void> clearUser() async {
    await secureStorage.clearUser();
  }
}

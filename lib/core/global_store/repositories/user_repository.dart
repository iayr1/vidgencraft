import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<void> cacheUser(UserEntity user);
  Future<UserEntity?> getCachedUser();
  Future<void> clearUser();
}

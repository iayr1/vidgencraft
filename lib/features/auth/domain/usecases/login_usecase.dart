import 'package:dartz/dartz.dart';
import 'package:vidgencraft/core/status/failures.dart';
import 'package:vidgencraft/features/auth/data/model/login/login_request_model.dart';
import 'package:vidgencraft/features/auth/data/model/login/login_response_model.dart';
import '../repositories/auth_repository_impl.dart';

class LoginUsecase {
  final AuthRepository _repository;

  const LoginUsecase(this._repository);

  Future<Either<Failure, LoginResponseModel>> call(
      LoginRequestModel body) async {
    return _repository.login(body);
  }
}
import 'package:dartz/dartz.dart';
import 'package:vidgencraft/core/status/failures.dart';
import 'package:vidgencraft/features/auth/data/model/resetpassword/reset_password_request_model.dart';
import 'package:vidgencraft/features/auth/data/model/resetpassword/reset_password_response_model.dart';

import '../repositories/auth_repository_impl.dart';

class ResetPasswordUsecase {
  final AuthRepository _repository;

  const ResetPasswordUsecase(this._repository);

  Future<Either<Failure, ResetPasswordResponseModel>> call(
      ResetPasswordRequestModel body) async {
    return _repository.resetPassword(body);
  }
}
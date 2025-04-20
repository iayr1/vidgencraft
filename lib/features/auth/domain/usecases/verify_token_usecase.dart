import 'package:dartz/dartz.dart';
import 'package:vidgencraft/core/status/failures.dart';
import 'package:vidgencraft/features/auth/data/model/getverifytoken/verify_token_model.dart';
import '../repositories/auth_repository_impl.dart';

class VerifyTokenUsecase {
  final AuthRepository _repository;

  const VerifyTokenUsecase(this._repository);

  Future<Either<Failure, VerifyResponseModel>> call() async {
    return _repository.verifyToken();
  }
}
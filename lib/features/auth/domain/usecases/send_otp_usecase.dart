import 'package:dartz/dartz.dart';
import 'package:vidgencraft/core/status/failures.dart';
import 'package:vidgencraft/features/auth/data/model/signup/signup_request_model.dart';
import 'package:vidgencraft/features/auth/data/model/signup/signup_response_model.dart';
import '../repositories/auth_repository_impl.dart';

class SendOtpUsecase {
  final AuthRepository _repository;

  const SendOtpUsecase(this._repository);

  Future<Either<Failure, SignUpResponseModel>> call(
      SignUpRequestModel body) async {
    return _repository.sendOtp(body);
  }
}
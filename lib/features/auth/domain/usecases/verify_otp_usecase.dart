import 'package:dartz/dartz.dart';
import 'package:vidgencraft/core/status/failures.dart';
import 'package:vidgencraft/features/auth/data/model/verifyotp/verify_otp_request_model.dart';
import 'package:vidgencraft/features/auth/data/model/verifyotp/verify_otp_response_model.dart';
import '../repositories/auth_repository_impl.dart';

class VerifyOtpUsecase {
  final AuthRepository _repository;

  const VerifyOtpUsecase(this._repository);

  Future<Either<Failure, VerifyOtpResponseModel>> call(
      VerifyOtpRequestModel body) async {
    return _repository.verifyOtp(body);
  }
}
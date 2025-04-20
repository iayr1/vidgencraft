import 'package:dartz/dartz.dart';
import 'package:vidgencraft/core/status/failures.dart';
import 'package:vidgencraft/features/auth/data/model/signup/signup_request_model.dart';
import 'package:vidgencraft/features/auth/data/model/signup/signup_response_model.dart';
import 'package:vidgencraft/features/auth/data/model/login/login_request_model.dart';
import 'package:vidgencraft/features/auth/data/model/login/login_response_model.dart';
import 'package:vidgencraft/features/auth/data/model/resetpassword/reset_password_request_model.dart';
import 'package:vidgencraft/features/auth/data/model/resetpassword/reset_password_response_model.dart';
import 'package:vidgencraft/features/auth/data/model/verifyotp/verify_otp_request_model.dart';
import 'package:vidgencraft/features/auth/data/model/verifyotp/verify_otp_response_model.dart';
import 'package:vidgencraft/features/auth/data/model/getverifytoken/verify_token_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, SignUpResponseModel>> sendOtp(SignUpRequestModel body);
  Future<Either<Failure, LoginResponseModel>> login(LoginRequestModel body);
  Future<Either<Failure, ResetPasswordResponseModel>> resetPassword(
      ResetPasswordRequestModel body);
  Future<Either<Failure, VerifyOtpResponseModel>> verifyOtp(
      VerifyOtpRequestModel body);
  Future<Either<Failure, VerifyResponseModel>> verifyToken();
}


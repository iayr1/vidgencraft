import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/exceptions/custom_exceptions.dart';
import '../../../../core/status/failures.dart';
import '../../../../core/utils/utils.dart';
import '../../data/datasources/auth_client.dart';
import '../../data/model/getverifytoken/verify_token_model.dart';
import '../../data/model/login/login_request_model.dart';
import '../../data/model/login/login_response_model.dart';
import '../../data/model/resetpassword/reset_password_request_model.dart';
import '../../data/model/resetpassword/reset_password_response_model.dart';
import '../../data/model/signup/signup_request_model.dart';
import '../../data/model/signup/signup_response_model.dart';
import '../../data/model/verifyotp/verify_otp_request_model.dart';
import '../../data/model/verifyotp/verify_otp_response_model.dart';
import '../../domain/repositories/auth_repository_impl.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthClient _client;

  const AuthRepositoryImpl(this._client);

  @override
  Future<Either<Failure, SignUpResponseModel>> sendOtp(
      SignUpRequestModel body) async {
    try {
      final response = await _client.sendOtp(body);
      return right(response);
    } on SocketException catch (_) {
      return left(ConnectionFailure());
    } on TimeoutException catch (_) {
      return left(TimeoutFailure());
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      Utils.debugLog(e.toString());
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, LoginResponseModel>> login(
      LoginRequestModel body) async {
    try {
      final response = await _client.login(body);
      return right(response);
    } on SocketException catch (_) {
      return left(ConnectionFailure());
    } on TimeoutException catch (_) {
      return left(TimeoutFailure());
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      Utils.debugLog(e.toString());
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, ResetPasswordResponseModel>> resetPassword(
      ResetPasswordRequestModel body) async {
    try {
      final response = await _client.resetPassword(body);
      return right(response);
    } on SocketException catch (_) {
      return left(ConnectionFailure());
    } on TimeoutException catch (_) {
      return left(TimeoutFailure());
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      Utils.debugLog(e.toString());
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, VerifyOtpResponseModel>> verifyOtp(
      VerifyOtpRequestModel body) async {
    try {
      final response = await _client.verifyOtp(body);
      return right(response);
    } on SocketException catch (_) {
      return left(ConnectionFailure());
    } on TimeoutException catch (_) {
      return left(TimeoutFailure());
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      Utils.debugLog(e.toString());
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, VerifyResponseModel>> verifyToken() async {
    try {
      final response = await _client.verifyToken();
      return right(response);
    } on SocketException catch (_) {
      return left(ConnectionFailure());
    } on TimeoutException catch (_) {
      return left(TimeoutFailure());
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      Utils.debugLog(e.toString());
      return left(GeneralFailure());
    }
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vidgencraft/core/status/failures.dart';
import 'package:vidgencraft/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:vidgencraft/features/auth/domain/usecases/login_usecase.dart';
import 'package:vidgencraft/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:vidgencraft/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:vidgencraft/features/auth/domain/usecases/verify_token_usecase.dart';
import 'package:vidgencraft/features/auth/data/model/signup/signup_request_model.dart';
import 'package:vidgencraft/features/auth/data/model/signup/signup_response_model.dart';
import 'package:vidgencraft/features/auth/data/model/login/login_request_model.dart';
import 'package:vidgencraft/features/auth/data/model/login/login_response_model.dart';
import 'package:vidgencraft/features/auth/data/model/resetpassword/reset_password_request_model.dart';
import 'package:vidgencraft/features/auth/data/model/resetpassword/reset_password_response_model.dart';
import 'package:vidgencraft/features/auth/data/model/verifyotp/verify_otp_request_model.dart';
import 'package:vidgencraft/features/auth/data/model/verifyotp/verify_otp_response_model.dart';
import 'package:vidgencraft/features/auth/data/model/getverifytoken/verify_token_model.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SendOtpUsecase _sendOtpUsecase;
  final LoginUsecase _loginUsecase;
  final ResetPasswordUsecase _resetPasswordUsecase;
  final VerifyOtpUsecase _verifyOtpUsecase;
  final VerifyTokenUsecase _verifyTokenUsecase;

  AuthCubit(
      this._sendOtpUsecase,
      this._loginUsecase,
      this._resetPasswordUsecase,
      this._verifyOtpUsecase,
      this._verifyTokenUsecase,
      ) : super(const AuthState.initial());

  Future<void> sendOtp(String email, String password) async {
    emit(const AuthState.sendingOtp());
    final response = await _sendOtpUsecase(
        SignUpRequestModel(email: email, password: password, confirmPassword: password));
    response.fold(
          (failure) => emit(AuthState.sendOtpError(failure.message)),
          (data) => emit(AuthState.sentOtp(data)),
    );
  }

  Future<void> login(String email, String password) async {
    emit(const AuthState.loggingIn());
    final response =
    await _loginUsecase(LoginRequestModel(email: email, password: password));
    response.fold(
          (failure) => emit(AuthState.loginError(failure.message)),
          (data) => emit(AuthState.loggedIn(data)),
    );
  }

  Future<void> resetPassword(String email) async {
    emit(const AuthState.resettingPassword());
    final response =
    await _resetPasswordUsecase(ResetPasswordRequestModel(email: email));
    response.fold(
          (failure) => emit(AuthState.resetPasswordError(failure.message)),
          (data) => emit(AuthState.resetPasswordSuccess(data)),
    );
  }

  Future<void> verifyOtp(String email, String otp) async {
    emit(const AuthState.verifyingOtp());
    final response =
    await _verifyOtpUsecase(VerifyOtpRequestModel(email: email, otp: otp));
    response.fold(
          (failure) => emit(AuthState.verifyOtpError(failure.message)),
          (data) => emit(AuthState.verifiedOtp(data)),
    );
  }

  Future<void> verifyToken() async {
    emit(const AuthState.verifyingToken());
    final response = await _verifyTokenUsecase();
    response.fold(
          (failure) => emit(AuthState.verifyTokenError(failure.message)),
          (data) => emit(AuthState.verifiedToken(data)),
    );
  }
}
part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;

  const factory AuthState.sendingOtp() = _SendingOtp;
  const factory AuthState.sentOtp(SignUpResponseModel response) = _SentOtp;
  const factory AuthState.sendOtpError(String error) = _SendOtpError;

  const factory AuthState.loggingIn() = _LoggingIn;
  const factory AuthState.loggedIn(LoginResponseModel response) = _LoggedIn;
  const factory AuthState.loginError(String error) = _LoginError;

  const factory AuthState.resettingPassword() = _ResettingPassword;
  const factory AuthState.resetPasswordSuccess(
      ResetPasswordResponseModel response) = _ResetPasswordSuccess;
  const factory AuthState.resetPasswordError(String error) =
  _ResetPasswordError;

  const factory AuthState.verifyingOtp() = _VerifyingOtp;
  const factory AuthState.verifiedOtp(VerifyOtpResponseModel response) =
  _VerifiedOtp;
  const factory AuthState.verifyOtpError(String error) = _VerifyOtpError;

  const factory AuthState.verifyingToken() = _VerifyingToken;
  const factory AuthState.verifiedToken(VerifyResponseModel response) =
  _VerifiedToken;
  const factory AuthState.verifyTokenError(String error) = _VerifyTokenError;
}
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:vidgencraft/features/auth/data/model/signup/signup_request_model.dart';
import 'package:vidgencraft/features/auth/data/model/signup/signup_response_model.dart';
import '../../../../core/constants/api_string.dart';
import '../model/getverifytoken/verify_token_model.dart';
import '../model/login/login_request_model.dart';
import '../model/login/login_response_model.dart';
import '../model/resetpassword/reset_password_request_model.dart';
import '../model/resetpassword/reset_password_response_model.dart';
import '../model/verifyotp/verify_otp_request_model.dart';
import '../model/verifyotp/verify_otp_response_model.dart';

part 'auth_client.g.dart';

@RestApi()
abstract class AuthClient {
  factory AuthClient(Dio dio) = _AuthClient;

  @POST(ApiString.signup)
  Future<SignUpResponseModel> sendOtp(
      @Body() SignUpRequestModel body,
      );

  @POST(ApiString.login)
  Future<LoginResponseModel> login(
      @Body() LoginRequestModel body,
      );

  @POST(ApiString.forgotPassword)
  Future<ResetPasswordResponseModel> resetPassword(
      @Body() ResetPasswordRequestModel body,
      );

  @POST(ApiString.verifyOtp)
  Future<VerifyOtpResponseModel> verifyOtp(
      @Body() VerifyOtpRequestModel body,
      );

  @GET(ApiString.verifyToken)
  Future<VerifyResponseModel> verifyToken();
}

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:vidgencraft/features/auth/data/model/signup/signup_request_model.dart';
import 'package:vidgencraft/features/auth/data/model/signup/signup_response_model.dart';
import '../../../../core/constants/api_string.dart';

part 'auth_client.g.dart';

@RestApi()
abstract class AuthClient {
  factory AuthClient(Dio dio) = _AuthClient;

  @POST(ApiString.signup)
  Future<SignUpResponseModel> sendOtp(
      @Body() SignUpRequestModel body,);

}
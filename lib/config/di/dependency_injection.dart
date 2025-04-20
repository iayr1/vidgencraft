import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:vidgencraft/config/routes/navigation_service.dart';
import 'package:vidgencraft/core/exceptions/custom_exceptions.dart';
import '../../core/constants/preference_string.dart';
import '../../core/themes/bloc/theme_bloc.dart';
import '../../core/utils/secure_local_storage.dart';
import '../../features/auth/data/datasources/auth_client.dart';
import '../../features/auth/data/respositories/auth_repository.dart';
import '../../features/auth/domain/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/reset_password_usecase.dart';
import '../../features/auth/domain/usecases/send_otp_usecase.dart';
import '../../features/auth/domain/usecases/verify_otp_usecase.dart';
import '../../features/auth/domain/usecases/verify_token_usecase.dart';
import '../../features/auth/presentation/bloc/auth_cubit.dart';
import '../routes/app_router.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // External Services
  sl.registerLazySingleton(() => SecureLocalStorage());
  sl.registerLazySingleton(() => NavigationService());

  // Dio Configuration
  final dio = Dio(
    BaseOptions(
      contentType: 'application/json',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    ),
  );

  dio.interceptors.addAll([
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        try {
          final authData = await getAuthData();
          options.headers['authorization'] = 'Bearer ${authData['accessToken']}';
        } catch (_) {}
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          try {
            final authData = await getAuthData();
            final newAuthData = await getNewAuthData(authData);
            error.requestOptions.headers['authorization'] =
            'Bearer ${newAuthData['accessToken']}';
            await setAuthData(newAuthData);
            final response = await dio.request(
              error.requestOptions.path,
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters,
              options: Options(
                method: error.requestOptions.method,
                headers: error.requestOptions.headers,
              ),
            );
            return handler.resolve(response);
          } catch (e) {
            if (e is CacheException) await goToLoginScreen();
            return handler.next(error);
          }
        }
        return handler.next(error);
      },
    ),
    if (kDebugMode)
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        error: true,
      ),
  ]);

  sl.registerSingleton<Dio>(dio);


  sl.registerLazySingleton(() => AuthClient(sl<Dio>()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
          () => AuthRepositoryImpl(sl()));

  // Use Cases
  sl.registerLazySingleton(() => SendOtpUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUsecase(sl()));
  sl.registerLazySingleton(() => VerifyOtpUsecase(sl()));
  sl.registerLazySingleton(() => VerifyTokenUsecase(sl()));

  // Cubit
  sl.registerFactory(() => AuthCubit(
    sl(),
    sl(),
    sl(),
    sl(),
    sl(),
  ));

  // Utility Functions
  sl.registerLazySingleton(() => getAuthData);
  sl.registerLazySingleton(() => setAuthData);
  sl.registerLazySingleton(() => getNewAuthData);
  sl.registerLazySingleton(() => goToLoginScreen);


  sl.registerSingleton<ThemeBloc>(ThemeBloc());
}

Future<Map<String, dynamic>> getAuthData() async {
  final result = await sl<SecureLocalStorage>().get(PreferenceString.userAuthData);
  if (result == null) throw CacheException();
  return jsonDecode(result);
}

Future<void> setAuthData(Map<String, dynamic> authData) async {
  await sl<SecureLocalStorage>()
      .set(PreferenceString.userAuthData, jsonEncode(authData));
}

Future<Map<String, dynamic>> getNewAuthData(Map<String, dynamic> authData) async {
  final dio = sl<Dio>();
  dio.options.headers['authorization'] = 'Bearer ${authData['refreshToken']}';
  final response = await dio.post('https://api.example.com/auth/refresh');
  if (response.data['statusCode'] == 200) {
    return {
      'accessToken': response.data['data']['accessToken'],
      'refreshToken': response.data['data']['refreshToken'],
    };
  }
  throw CacheException();
}

Future<void> goToLoginScreen() async {
  await sl<SecureLocalStorage>().deleteAll();
  final context = sl<NavigationService>().navigatorKey.currentContext!;
  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
}
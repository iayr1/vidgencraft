// TODO: Define app navigation routes
import 'package:flutter/material.dart';
import 'package:vidgencraft/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:vidgencraft/features/auth/presentation/screens/login_screen.dart';
import 'package:vidgencraft/features/auth/presentation/screens/signup_screen.dart';
import 'package:vidgencraft/features/auth/presentation/screens/verity_otp_screen.dart';
import 'package:vidgencraft/features/home/presentation/home_screen.dart';
import 'package:vidgencraft/features/image_to_video/presentation/screens/image_to_video_screen.dart';
import 'package:vidgencraft/features/profile/presentation/screens/profile_screen.dart';
import 'package:vidgencraft/features/splash/presentation/splash_screen.dart';
import 'package:vidgencraft/features/text_to_image/presentation/screens/text_to_image_screen.dart';
import 'package:vidgencraft/features/text_to_video/presentation/screens/text_to_video_screen.dart';

class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const signup = '/signup';
  static const imagetovideo = '/imagetovideo';
  static const texttoimage = '/texttoimage';
  static const texttovideo = '/texttovideo';
  static const profilepage = '/profilepage';
  static const homescreen = '/homescreen';
  static const resetpassword = '/resetpassword';
  static const verifyotp = '/verifyotp';

  static final navigatorKey = GlobalKey<NavigatorState>();

  static Route<dynamic> generate(RouteSettings settings) {
    final routes = {
      splash: (context) =>  SplashScreen(),
      login: (context) => const LoginScreen(),
      signup: (context) => const SignUpScreen(),
      imagetovideo: (context) => const ImageToVideoScreen(),
      texttoimage: (context) => const TextToImageScreen(),
      texttovideo: (context) => const TextToVideoScreen(),
      profilepage: (context) => const ProfilePageWrapper(),
      homescreen: (context) => const HomeScreen(),
      resetpassword: (context) => const ForgotPasswordScreen(),
      verifyotp: (context) => const VerifyOtpScreen(),
    };

    final builder = routes[settings.name];
    return MaterialPageRoute(
      builder: builder ?? (_) => _errorScreen(settings.name),
    );
  }

  static Widget _errorScreen(String? name) => Scaffold(
    body: Center(child: Text('No route found: $name')),
  );

  // Optional: Navigate from anywhere
  static Future<dynamic> navigateTo(String route, {Object? args}) {
    return navigatorKey.currentState!.pushNamed(route, arguments: args);
  }

  static void goBack() {
    navigatorKey.currentState!.pop();
  }
}

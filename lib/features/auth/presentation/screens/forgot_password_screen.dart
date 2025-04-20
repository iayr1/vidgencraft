import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../core/constants/api_string.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_textstyles.dart';
import '../../../../core/utils/windows.dart';
import '../../../../core/widgets/custom_action_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  late AnimationController _animationController;
  bool _isLoading = false;
  String? _errorMessage;
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiString.baseUrl,
    headers: {'Content-Type': 'application/json'},
  ));

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        final response = await _dio.post(
          ApiString.resetPassword,
          data: {'email': _emailController.text},
        );

        setState(() {
          _isLoading = false;
        });

        final result = response.data;

        if (response.statusCode == 200 && result['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Password reset link sent to ${_emailController.text}',
                style: AppTextStyles.bodyRegular.copyWith(color: AppColors.neutral10),
              ),
              backgroundColor: AppColors.secondaryGreen80,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
          );
          Navigator.pushNamed(
            context,
            AppRoutes.verifyotp,
            arguments: _emailController.text,
          );
        } else {
          setState(() {
            _errorMessage = result['error'] ?? 'Failed to send reset link';
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Error: $_errorMessage',
                style: AppTextStyles.bodyRegular.copyWith(color: AppColors.neutral10),
              ),
              backgroundColor: AppColors.error60,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
          );
        }
      } on DioException catch (e) {
        setState(() {
          _isLoading = false;
        });

        // Log detailed error information
        debugPrint('DioException: ${e.message}');
        debugPrint('Error Type: ${e.type}');
        debugPrint('Response: ${e.response?.toString()}');
        debugPrint('Request URL: ${e.requestOptions.uri}');
        debugPrint('Request Data: ${e.requestOptions.data}');

        String errorMessage;
        switch (e.type) {
          case DioExceptionType.connectionTimeout:
            errorMessage = 'Connection timeout. Please check your internet connection.';
            break;
          case DioExceptionType.sendTimeout:
            errorMessage = 'Request timeout. Unable to send data to the server.';
            break;
          case DioExceptionType.receiveTimeout:
            errorMessage = 'Response timeout. Server took too long to respond.';
            break;
          case DioExceptionType.badResponse:
            errorMessage = 'Server error: ${e.response?.statusCode} ${e.response?.data['error'] ?? 'Unknown error'}';
            break;
          case DioExceptionType.cancel:
            errorMessage = 'Request was cancelled.';
            break;
          case DioExceptionType.connectionError:
            errorMessage = 'Connection error. Unable to reach the server.';
            break;
          case DioExceptionType.badCertificate:
            errorMessage = 'Invalid SSL certificate.';
            break;
          case DioExceptionType.unknown:
          default:
            errorMessage = 'Network error: ${e.message}';
            break;
        }

        setState(() {
          _errorMessage = errorMessage;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error: $_errorMessage',
              style: AppTextStyles.bodyRegular.copyWith(color: AppColors.neutral10),
            ),
            backgroundColor: AppColors.error60,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? AppColors.darkPrimary10 : AppColors.primary10;
    final textColor = isDarkMode ? AppColors.darkNeutral90 : AppColors.neutral90;
    final hintColor = isDarkMode ? AppColors.darkNeutral50 : AppColors.neutral50;
    final borderColor = isDarkMode ? AppColors.accentGlow : AppColors.primary;
    final focusedBorderColor = isDarkMode ? AppColors.accentGlow : AppColors.primary60;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? AppColors.accentGlow : AppColors.neutral80,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: Window.getPadding(all: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reset Password',
                  style: AppTextStyles.heading3Bold.copyWith(
                    color: textColor,
                    letterSpacing: 1.2,
                  ),
                ).animate(controller: _animationController).fadeIn(duration: 600.ms).slideY(begin: -0.1),
                SizedBox(height: Window.getVerticalSize(16)),
                Text(
                  'Enter your email to receive a link to reset your password.',
                  style: AppTextStyles.bodyRegular.copyWith(
                    color: isDarkMode ? AppColors.darkNeutral60 : AppColors.neutral60,
                  ),
                ).animate(controller: _animationController).fadeIn(delay: 200.ms),
                SizedBox(height: Window.getVerticalSize(32)),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isDarkMode
                          ? [AppColors.darkNeutral70.withOpacity(0.3), AppColors.darkNeutral80.withOpacity(0.3)]
                          : [AppColors.neutral20.withOpacity(0.3), AppColors.neutral30.withOpacity(0.3)],
                    ),
                    borderRadius: BorderRadius.circular(Window.getRadiusSize(15)),
                    border: Border.all(
                      color: borderColor.withOpacity(0.5),
                      width: 1.5,
                    ),
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: AppTextStyles.bodyRegular.copyWith(color: hintColor),
                      hintText: 'm@example.com',
                      hintStyle: AppTextStyles.bodyRegular.copyWith(color: hintColor),
                      filled: false,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Window.getRadiusSize(15)),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Window.getRadiusSize(15)),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Window.getRadiusSize(15)),
                        borderSide: BorderSide.none,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Window.getRadiusSize(15)),
                        borderSide: BorderSide.none,
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Window.getRadiusSize(15)),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    style: AppTextStyles.bodyRegular.copyWith(color: textColor),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onChanged: (_) => setState(() {}),
                  ),
                ).animate(controller: _animationController).fadeIn(delay: 400.ms).slideX(begin: 0.1),
                SizedBox(height: Window.getVerticalSize(24)),
                CustomActionButton(
                  name: 'Send Reset Link',
                  isFormFilled: _emailController.text.isNotEmpty,
                  isLoaded: !_isLoading,
                  onTap: (startLoading, stopLoading, btnState) => _resetPassword(),
                ).animate(controller: _animationController).fadeIn(delay: 600.ms).scale(),
                SizedBox(height: Window.getVerticalSize(16)),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Back to Login',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: isDarkMode ? AppColors.accentGlow : AppColors.primary60,
                      ),
                    ),
                  ),
                ).animate(controller: _animationController).fadeIn(delay: 800.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
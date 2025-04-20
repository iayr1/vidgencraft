import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vidgencraft/core/constants/app_colors.dart';
import 'package:vidgencraft/core/constants/app_textstyles.dart';
import 'package:vidgencraft/core/widgets/custom_action_button.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../core/constants/api_string.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> obscurePassword = ValueNotifier(true);
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
    emailController.dispose();
    passwordController.dispose();
    obscurePassword.dispose();
    _animationController.dispose();
    super.dispose();
  }

  bool get isButtonDisabled =>
      emailController.text.isEmpty || passwordController.text.isEmpty;

  Future<void> _login() async {
    if (isButtonDisabled) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await _dio.post(
        ApiString.login,
        data: {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );

      setState(() {
        _isLoading = false;
      });

      final result = response.data;

      if (response.statusCode == 200 && result['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Logged in successfully',
              style: AppTextStyles.bodyRegular.copyWith(color: AppColors.neutral10),
            ),
            backgroundColor: AppColors.secondaryGreen80,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        );
        Navigator.pushNamed(context, AppRoutes.homescreen);
      } else {
        setState(() {
          _errorMessage = result['error'] ?? 'Failed to login';
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
          backgroundColor: AppColors.neutral100,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColorStart = isDarkMode ? AppColors.darkNeutral90 : AppColors.neutral10;
    final backgroundColorEnd = isDarkMode ? AppColors.darkNeutral80 : AppColors.neutral10;
    final borderColor = isDarkMode ? AppColors.accentGlow : AppColors.primary;
    final textColor = isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [backgroundColorStart, backgroundColorEnd],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Header
                      Text(
                        "Welcome Back!",
                        style: AppTextStyles.heading3Bold.copyWith(
                          color: textColor,
                          letterSpacing: 1.2,
                        ),
                      ).animate(controller: _animationController).fadeIn(duration: 600.ms).slideY(begin: -0.1),
                      const SizedBox(height: 12),
                      Text(
                        "Log in to continue your creative journey",
                        style: AppTextStyles.subtitleRegular.copyWith(
                          color: textColor.withOpacity(0.8),
                        ),
                      ).animate(controller: _animationController).fadeIn(delay: 200.ms),
                      const SizedBox(height: 32),

                      // Email Field
                      _buildLabel("Email", textColor),
                      const SizedBox(height: 8),
                      _buildTextField(
                        controller: emailController,
                        hint: "m@example.com",
                        isDarkMode: isDarkMode,
                        textColor: textColor,
                        borderColor: borderColor,
                        onChanged: () => setState(() {}),
                      ).animate(controller: _animationController).fadeIn(delay: 400.ms).slideX(begin: 0.1),
                      const SizedBox(height: 20),

                      // Password Field
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildLabel("Password", textColor),
                          TextButton(
                            onPressed: () => Navigator.pushNamed(context, AppRoutes.resetpassword),
                            child: Text(
                              "Forgot Password?",
                              style: AppTextStyles.captionRegular.copyWith(
                                color: isDarkMode ? AppColors.accentGlow : AppColors.primary90,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ValueListenableBuilder(
                        valueListenable: obscurePassword,
                        builder: (_, value, __) => _buildTextField(
                          controller: passwordController,
                          hint: "Enter your password",
                          isObscure: value,
                          isDarkMode: isDarkMode,
                          textColor: textColor,
                          borderColor: borderColor,
                          suffix: IconButton(
                            icon: Icon(
                              value ? Icons.visibility_off : Icons.visibility,
                              color: isDarkMode ? AppColors.accentGlow.withOpacity(0.7) : AppColors.neutral60,
                            ),
                            onPressed: () => obscurePassword.value = !value,
                          ),
                          onChanged: () => setState(() {}),
                        ),
                      ).animate(controller: _animationController).fadeIn(delay: 600.ms).slideX(begin: 0.1),
                      const SizedBox(height: 24),

                      // Log In Button
                      CustomActionButton(
                        name: "Log In",
                        isFormFilled: !isButtonDisabled,
                        isLoaded: !_isLoading,
                        onTap: (startLoading, stopLoading, btnState) => // _login(),
                        {
                          Navigator.pushNamed(context, AppRoutes.homescreen),
                        }
                      ).animate(controller: _animationController).fadeIn(delay: 900.ms).scale(),
                      const SizedBox(height: 20),

                      // Divider
                      Divider(
                        color: isDarkMode ? AppColors.accentGlow.withOpacity(0.3) : AppColors.neutral30,
                        thickness: 1.5,
                      ).animate(controller: _animationController).fadeIn(delay: 800.ms),
                      const SizedBox(height: 20),

                      // Or Continue With
                      Center(
                        child: Text(
                          "Or continue with",
                          style: AppTextStyles.captionRegular.copyWith(
                            color: textColor.withOpacity(0.8),
                          ),
                        ),
                      ).animate(controller: _animationController).fadeIn(delay: 900.ms),
                      const SizedBox(height: 20),

                      // Google Button
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/google.png',
                          height: 30,
                          width: 30,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.error,
                            color: isDarkMode ? AppColors.accentGlow : AppColors.primary,
                          ),
                        ),
                        label: Text(
                          "Login with Google",
                          style: AppTextStyles.bodyBold.copyWith(
                            color: textColor,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 56),
                          side: BorderSide(color: borderColor.withOpacity(0.7), width: 2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          backgroundColor: isDarkMode
                              ? AppColors.darkNeutral70.withOpacity(0.3)
                              : AppColors.neutral20.withOpacity(0.3),
                        ),
                      ).animate(controller: _animationController).fadeIn(delay: 1000.ms).scale(),
                      const SizedBox(height: 20),

                      // Sign Up Link
                      Center(
                        child: TextButton(
                          onPressed: () => Navigator.pushNamed(context, AppRoutes.signup),
                          child: Text(
                            "Don't have an account? Sign up",
                            style: AppTextStyles.subtitleRegular.copyWith(
                              color: isDarkMode ? AppColors.accentGlow : AppColors.primary90,
                            ),
                          ),
                        ),
                      ).animate(controller: _animationController).fadeIn(delay: 1100.ms),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, Color textColor) {
    return Text(
      text,
      style: AppTextStyles.captionBold.copyWith(
        color: textColor.withOpacity(0.8),
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required bool isDarkMode,
    required Color textColor,
    required Color borderColor,
    Widget? suffix,
    bool isObscure = false,
    required VoidCallback onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDarkMode
              ? [AppColors.darkNeutral70.withOpacity(0.3), AppColors.darkNeutral80.withOpacity(0.3)]
              : [AppColors.neutral20.withOpacity(0.3), AppColors.neutral30.withOpacity(0.3)],
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: borderColor.withOpacity(0.5),
          width: 1.5,
        ),
      ),
      child: TextField(
        cursorColor: borderColor,
        cursorWidth: 2,
        controller: controller,
        obscureText: isObscure,
        keyboardType: hint.contains('email') ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.bodyRegular.copyWith(
            color: isDarkMode ? AppColors.darkNeutral40 : AppColors.neutral50,
          ),
          filled: false,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          suffixIcon: suffix,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        style: AppTextStyles.bodyRegular.copyWith(color: textColor),
        onChanged: (_) => onChanged(),
      ),
    );
  }
}
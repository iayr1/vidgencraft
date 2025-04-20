import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_textstyles.dart';
import '../../../../core/widgets/custom_action_button.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final ValueNotifier<bool> obscurePassword = ValueNotifier(true);
  final ValueNotifier<bool> obscureConfirmPassword = ValueNotifier(true);
  late AnimationController _animationController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    obscurePassword.dispose();
    obscureConfirmPassword.dispose();
    _animationController.dispose();
    super.dispose();
  }


  bool get isButtonDisabled =>
      emailController.text.isEmpty ||
          passwordController.text.isEmpty ||
          confirmPasswordController.text.isEmpty;


  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColorStart = isDarkMode ? AppColors.darkNeutral90 : AppColors.neutral10;
    final backgroundColorEnd = isDarkMode ? AppColors.darkNeutral80 : AppColors.neutral10;
    final borderColor = isDarkMode ? AppColors.darkPrimary : AppColors.primary90;
    final textColor = isDarkMode ? AppColors.neutral10 : AppColors.neutral80;


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
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create an account",
                        style: AppTextStyles.heading3Bold.copyWith(
                          color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
                        ),
                      ).animate(controller: _animationController).fadeIn().slideY(begin: 0.2),
                      const SizedBox(height: 12),
                      Text(
                        "Enter your email below to create your account",
                        style: AppTextStyles.subtitleRegular.copyWith(color: textColor),
                      ).animate(controller: _animationController).fadeIn(delay: 200.ms),
                      const SizedBox(height: 32),

                      /// Email Field
                      _buildLabel("Email", isDarkMode),
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

                      /// Password Field
                      _buildLabel("Password", isDarkMode),
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
                              color: isDarkMode ? AppColors.darkNeutral20 : AppColors.neutral60,
                            ),
                            onPressed: () => obscurePassword.value = !value,
                          ),
                          onChanged: () => setState(() {}),
                        ),
                      ).animate(controller: _animationController).fadeIn(delay: 600.ms).slideX(begin: 0.1),

                      const SizedBox(height: 20),

                      /// Confirm Password Field
                      _buildLabel("Confirm Password", isDarkMode),
                      const SizedBox(height: 8),
                      ValueListenableBuilder(
                        valueListenable: obscureConfirmPassword,
                        builder: (_, value, __) => _buildTextField(
                          controller: confirmPasswordController,
                          hint: "Confirm your password",
                          isObscure: value,
                          isDarkMode: isDarkMode,
                          textColor: textColor,
                          borderColor: borderColor,
                          suffix: IconButton(
                            icon: Icon(
                              value ? Icons.visibility_off : Icons.visibility,
                              color: isDarkMode ? AppColors.darkNeutral20 : AppColors.neutral60,
                            ),
                            onPressed: () => obscureConfirmPassword.value = !value,
                          ),
                          onChanged: () => setState(() {}),
                        ),
                      ).animate(controller: _animationController).fadeIn(delay: 800.ms).slideX(begin: 0.1),

                      const SizedBox(height: 24),

                      /// Sign Up Button
                      CustomActionButton(
                        name: "Sign up",
                        isFormFilled: !isButtonDisabled,
                        onTap: (startLoading, stopLoading, btnState) async {
                            startLoading();
                            await Future.delayed(const Duration(seconds: 2)); // simulate API call
                            stopLoading();

                            Navigator.pushNamed(context, AppRoutes.verifyotp);
                        },
                      ).animate(controller: _animationController).fadeIn(delay: 900.ms).scale(),

                      const SizedBox(height: 20),

                      Center(
                        child: TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          ),
                          child: Text(
                            "Already have an account? Log in",
                            style: AppTextStyles.subtitleRegular.copyWith(color: isDarkMode ? AppColors.neutral10 : AppColors.primary90),
                          ),
                        ),
                      ).animate(controller: _animationController).fadeIn(delay: 1000.ms),

                      const SizedBox(height: 20),

                      const Divider(color: AppColors.neutral30, thickness: 1.5)
                          .animate(controller: _animationController)
                          .fadeIn(delay: 1100.ms),
                      const SizedBox(height: 20),

                      Center(
                        child: Text("Or continue with", style: AppTextStyles.captionRegular.copyWith(color: textColor)),
                      ).animate(controller: _animationController).fadeIn(delay: 1200.ms),

                      const SizedBox(height: 20),

                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/google.png', // Your Google icon path
                          height: 24,
                          width: 24,
                        ),
                        label: Text(
                          "Continue with Google",
                          style: AppTextStyles.bodyBold.copyWith(
                            color: isDarkMode ? AppColors.neutral10 : AppColors.neutral80,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 56),
                          side: BorderSide(color: borderColor, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: isDarkMode
                              ? AppColors.darkNeutral70.withOpacity(0.2)
                              : AppColors.neutral20,
                        ),
                      )
                          .animate(controller: _animationController)
                          .fadeIn(delay: const Duration(milliseconds: 1000))
                          .scale(),
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

  Widget _buildLabel(String text, bool isDarkMode) {
    return Text(
      text,
      style: AppTextStyles.captionBold.copyWith(
        color: isDarkMode ? AppColors.neutral10 : AppColors.neutral60,
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
    return TextField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.bodyRegular.copyWith(
          color: isDarkMode ? AppColors.darkNeutral40 : AppColors.neutral50,
        ),
        filled: true,
        fillColor: isDarkMode ? AppColors.darkNeutral70.withOpacity(0.3) : AppColors.neutral20,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: borderColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: borderColor.withOpacity(0.7), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: borderColor, width: 2),
        ),
        suffixIcon: suffix,
      ),
      style: AppTextStyles.bodyRegular.copyWith(color: textColor),
      onChanged: (_) => onChanged(),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_textstyles.dart';
import '../../../../core/utils/windows.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      // Simulate password reset API call
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Password reset link sent to ${_emailController.text}',
            style: AppTextStyles.bodyRegular.copyWith(color: AppColors.neutral10),
          ),
          backgroundColor: AppColors.secondaryGreen80,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary10,
      appBar: AppBar(
        backgroundColor: AppColors.primary10,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.neutral80),
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
                    color: AppColors.neutral90,
                  ),
                ),
                SizedBox(height: Window.getVerticalSize(16)),
                Text(
                  'Enter your email address and we’ll send you a link to reset your password.',
                  style: AppTextStyles.bodyRegular.copyWith(
                    color: AppColors.neutral60,
                  ),
                ),
                SizedBox(height: Window.getVerticalSize(32)),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: AppTextStyles.bodyRegular.copyWith(
                      color: AppColors.neutral50,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.neutral30),
                      borderRadius: BorderRadius.circular(
                        Window.getRadiusSize(8),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary60),
                      borderRadius: BorderRadius.circular(
                        Window.getRadiusSize(8),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.error60),
                      borderRadius: BorderRadius.circular(
                        Window.getRadiusSize(8),
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.error60),
                      borderRadius: BorderRadius.circular(
                        Window.getRadiusSize(8),
                      ),
                    ),
                  ),
                  style: AppTextStyles.bodyRegular.copyWith(
                    color: AppColors.neutral90,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+ Outfitters@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Window.getVerticalSize(24)),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _resetPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary60,
                      padding: Window.getSymmetricPadding(
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          Window.getRadiusSize(8),
                        ),
                      ),
                    ),
                    child: _isLoading
                        ? SizedBox(
                      width: Window.getSize(24),
                      height: Window.getSize(24),
                      child: CircularProgressIndicator(
                        color: AppColors.neutral10,
                        strokeWidth: Window.getSize(2),
                      ),
                    )
                        : Text(
                      'Send Reset Link',
                      style: AppTextStyles.subtitleBold.copyWith(
                        color: AppColors.neutral10,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Window.getVerticalSize(16)),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Back to Login',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary60,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
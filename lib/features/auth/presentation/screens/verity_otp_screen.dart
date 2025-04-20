import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_textstyles.dart';
import '../../../../core/utils/windows.dart';

class VerifyOtpScreen extends StatefulWidget {
  // final String email ; // Email passed from forgot password screen
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpControllers = List.generate(6, (_) => TextEditingController());
  bool _isLoading = false;
  final String email = "mayur@gmail.com";

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _verifyOtp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      // Simulate OTP verification API call
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'OTP verified successfully',
            style: AppTextStyles.bodyRegular.copyWith(color: AppColors.neutral10),
          ),
          backgroundColor: AppColors.secondaryGreen80,
        ),
      );
      // Navigate to reset password screen or next step
    }
  }

  void _resendOtp() async {
    setState(() {
      _isLoading = true;
    });
    // Simulate resend OTP API call
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'New OTP sent to ${email}',
          style: AppTextStyles.bodyRegular.copyWith(color: AppColors.neutral10),
        ),
        backgroundColor: AppColors.secondaryGreen80,
      ),
    );
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
                  'Verify OTP',
                  style: AppTextStyles.heading3Bold.copyWith(
                    color: AppColors.neutral90,
                  ),
                ),
                SizedBox(height: Window.getVerticalSize(16)),
                Text(
                  'Enter the 6-digit code sent to ${email}',
                  style: AppTextStyles.bodyRegular.copyWith(
                    color: AppColors.neutral60,
                  ),
                ),
                SizedBox(height: Window.getVerticalSize(32)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: Window.getHorizontalSize(48),
                      child: TextFormField(
                        controller: _otpControllers[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          counterText: '',
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
                            return ' ';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value.length == 1 && index < 5) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    );
                  }),
                ),
                SizedBox(height: Window.getVerticalSize(24)),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _verifyOtp,
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
                      'Verify OTP',
                      style: AppTextStyles.subtitleBold.copyWith(
                        color: AppColors.neutral10,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Window.getVerticalSize(16)),
                Center(
                  child: TextButton(
                    onPressed: _isLoading ? null : _resendOtp,
                    child: Text(
                      'Resend OTP',
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
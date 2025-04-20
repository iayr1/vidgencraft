import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vidgencraft/core/constants/app_colors.dart';
import 'package:vidgencraft/core/constants/app_textstyles.dart';
import 'package:vidgencraft/core/utils/windows.dart';
import 'package:vidgencraft/core/widgets/custom_action_button.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../core/constants/api_string.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  bool _isLoading = false;
  String? _errorMessage;
  bool _canResend = true;
  bool _otpSent = false;
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
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    _animationController.dispose();
    super.dispose();
  }

  bool get isEmailValid =>
      _emailController.text.isNotEmpty &&
          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailController.text);

  bool get isOtpValid => !_otpControllers.any((controller) => controller.text.isEmpty);

  Future<void> _sendOtp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        final response = await _dio.post(
          ApiString.forgotPassword,
          data: {'email': _emailController.text},
        );

        setState(() {
          _isLoading = false;
        });

        final result = response.data;

        if (response.statusCode == 200 && result['success'] == true) {
          setState(() {
            _otpSent = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'OTP sent to ${_emailController.text}',
                style: AppTextStyles.bodyRegular.copyWith(color: AppColors.neutral10),
              ),
              backgroundColor: AppColors.secondaryGreen80,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
          );
        } else {
          setState(() {
            _errorMessage = result['error'] ?? 'Failed to send OTP';
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

  Future<void> _verifyOtp() async {
    if (!isOtpValid) return;

    final otp = _otpControllers.map((c) => c.text).join();

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await _dio.post(
        ApiString.verifyOtp,
        data: {
          'email': _emailController.text,
          'otp': otp,
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
              'OTP verified successfully',
              style: AppTextStyles.bodyRegular.copyWith(color: AppColors.neutral10),
            ),
            backgroundColor: AppColors.secondaryGreen80,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        );
        Navigator.pushNamed(
          context,
          AppRoutes.resetpassword,
          arguments: _emailController.text,
        );
      } else {
        setState(() {
          _errorMessage = result['error'] ?? 'Failed to verify OTP';
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
        _errorMessage = e.response?.data['error'] ?? 'Network error: ${e.message}';
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
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Unexpected error: $e';
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

  Future<void> _resendOtp() async {
    if (!_canResend || !isEmailValid) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _canResend = false;
    });

    try {
      final response = await _dio.post(
        ApiString.forgotPassword,
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
              'OTP resent to ${_emailController.text}',
              style: AppTextStyles.bodyRegular.copyWith(color: AppColors.neutral10),
            ),
            backgroundColor: AppColors.secondaryGreen80,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        );
        // Reset OTP fields
        for (var controller in _otpControllers) {
          controller.clear();
        }
        _focusNodes[0].requestFocus();
        // Allow resending after 30 seconds
        Future.delayed(const Duration(seconds: 30), () {
          setState(() {
            _canResend = true;
          });
        });
      } else {
        setState(() {
          _errorMessage = result['error'] ?? 'Failed to resend OTP';
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
        _errorMessage = e.response?.data['error'] ?? 'Network error: ${e.message}';
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
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Unexpected error: $e';
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

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? AppColors.darkPrimary10 : AppColors.primary10;
    final textColor = isDarkMode ? AppColors.darkNeutral90 : AppColors.neutral90;
    final hintColor = isDarkMode ? AppColors.darkNeutral50 : AppColors.neutral50;
    final borderColor = isDarkMode ? AppColors.accentGlow : AppColors.primary;

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
                  'Verify OTP',
                  style: AppTextStyles.heading3Bold.copyWith(
                    color: textColor,
                    letterSpacing: 1.2,
                  ),
                ).animate(controller: _animationController).fadeIn(duration: 600.ms).slideY(begin: -0.1),
                SizedBox(height: Window.getVerticalSize(16)),
                Text(
                  _otpSent
                      ? 'Enter the 6-digit code sent to ${_emailController.text}'
                      : 'Enter your email to receive an OTP',
                  style: AppTextStyles.bodyRegular.copyWith(
                    color: isDarkMode ? AppColors.darkNeutral60 : AppColors.neutral60,
                  ),
                ).animate(controller: _animationController).fadeIn(delay: 200.ms),
                SizedBox(height: Window.getVerticalSize(32)),
                // Email Field
                Text(
                  'Email',
                  style: AppTextStyles.captionBold.copyWith(
                    color: textColor.withOpacity(0.8),
                    letterSpacing: 0.5,
                  ),
                ).animate(controller: _animationController).fadeIn(delay: 300.ms),
                const SizedBox(height: 8),
                Container(
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
                      color: _errorMessage != null && _emailController.text.isEmpty
                          ? AppColors.error60
                          : borderColor.withOpacity(0.5),
                      width: 1.5,
                    ),
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'm@example.com',
                      hintStyle: AppTextStyles.bodyRegular.copyWith(color: hintColor),
                      filled: false,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      errorStyle: AppTextStyles.captionRegular.copyWith(color: AppColors.error60),
                    ),
                    style: AppTextStyles.bodyRegular.copyWith(color: textColor),
                    cursorColor: borderColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onChanged: (value) => setState(() {}),
                  ),
                ).animate(controller: _animationController).fadeIn(delay: 400.ms).slideX(begin: 0.1),
                SizedBox(height: Window.getVerticalSize(24)),
                // OTP Fields or Send OTP Button
                if (_otpSent) ...[
                  Text(
                    'OTP Code',
                    style: AppTextStyles.captionBold.copyWith(
                      color: textColor.withOpacity(0.8),
                      letterSpacing: 0.5,
                    ),
                  ).animate(controller: _animationController).fadeIn(delay: 500.ms),
                  SizedBox(height: Window.getVerticalSize(8)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: Window.getHorizontalSize(48),
                        child: Container(
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
                              color: _errorMessage != null && _otpControllers[index].text.isEmpty
                                  ? AppColors.error60
                                  : borderColor.withOpacity(0.5),
                              width: 1.5,
                            ),
                          ),
                          child: TextFormField(
                            controller: _otpControllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            style: AppTextStyles.bodyRegular.copyWith(
                              color: textColor,
                            ),
                            cursorColor: borderColor,
                            onChanged: (value) {
                              setState(() {});
                              if (value.length == 1 && index < 5) {
                                _focusNodes[index].unfocus();
                                _focusNodes[index + 1].requestFocus();
                              } else if (value.isEmpty && index > 0) {
                                _focusNodes[index].unfocus();
                                _focusNodes[index - 1].requestFocus();
                              }
                            },
                          ),
                        ),
                      );
                    }),
                  ).animate(controller: _animationController).fadeIn(delay: 600.ms).slideX(begin: 0.1),
                  SizedBox(height: Window.getVerticalSize(24)),
                ],
                // Action Button and Resend Link
                Column(
                  children: [
                    CustomActionButton(
                      name: _otpSent ? 'Verify OTP' : 'Send OTP',
                      isFormFilled: _otpSent ? isOtpValid : isEmailValid,
                      isLoaded: !_isLoading,
                      onTap: (startLoading, stopLoading, btnState) => _otpSent ? _verifyOtp() : _sendOtp(),
                    ).animate(controller: _animationController).fadeIn(delay: 800.ms).scale(),
                    SizedBox(height: Window.getVerticalSize(16)),
                    if (_otpSent)
                      Center(
                        child: TextButton(
                          onPressed: _canResend ? () => _resendOtp() : null,
                          child: Text(
                            'Resend OTP',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: _canResend
                                  ? (isDarkMode ? AppColors.accentGlow : AppColors.primary60)
                                  : AppColors.neutral50,
                            ),
                          ),
                        ),
                      ).animate(controller: _animationController).fadeIn(delay: 1000.ms),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_textstyles.dart';
import '../../../../core/utils/windows.dart';
import '../../../../core/widgets/custom_action_button.dart';

class TextToImageScreen extends StatefulWidget {
  const TextToImageScreen({super.key});

  @override
  State<TextToImageScreen> createState() => _TextToImageScreenState();
}

class _TextToImageScreenState extends State<TextToImageScreen> {
  String _selectedOutputType = 'JPEG';
  String _selectedDimension = '1:1 (Square)';
  String _selectedStyle = 'NONE (Default)';
  final TextEditingController _promptController = TextEditingController();
  final TextEditingController _seedController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  String? _generatedImageUrl;

  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.218.191:8001',
    headers: {'Content-Type': 'application/json'},
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  @override
  void initState() {
    super.initState();
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      logPrint: (object) => debugPrint(object.toString()),
    ));
  }

  @override
  void dispose() {
    _promptController.dispose();
    _seedController.dispose();
    super.dispose();
  }

  Future<void> _generateImage() async {
    if (_promptController.text.trim().isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a prompt';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _generatedImageUrl = null;
    });

    try {
      debugPrint('Request URL: http://192.168.218.191:8001/generate_ai_background');
      debugPrint('Request Data: ${{'prompt': _promptController.text}}');

      final response = await _dio.post(
        '/generate_ai_background',
        data: {
          'prompt': _promptController.text,
          'output_type': _selectedOutputType.toLowerCase(),
          'dimension': _selectedDimension.split(' ')[0],
          'style': _selectedStyle == 'NONE (Default)' ? null : _selectedStyle.toLowerCase(),
          'seed': _seedController.text.isNotEmpty ? int.tryParse(_seedController.text) : null,
        },
      );

      final result = response.data;

      if (response.statusCode == 200 && result['success'] == true) {
        setState(() {
          _generatedImageUrl = result['image_url'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = result['error'] ?? 'Failed to generate image';
          _isLoading = false;
        });
      }
    } on DioException catch (e) {
      setState(() {
        _isLoading = false;
        switch (e.type) {
          case DioExceptionType.connectionTimeout:
            _errorMessage = 'Connection timeout. Please check your internet connection.';
            break;
          case DioExceptionType.sendTimeout:
            _errorMessage = 'Request timeout. Unable to send data to the server.';
            break;
          case DioExceptionType.receiveTimeout:
            _errorMessage = 'Response timeout. Server took too long to respond.';
            break;
          case DioExceptionType.badResponse:
            _errorMessage = 'Server error: ${e.response?.statusCode} ${e.response?.data['error'] ?? 'Unknown error'}';
            break;
          case DioExceptionType.cancel:
            _errorMessage = 'Request was cancelled.';
            break;
          case DioExceptionType.connectionError:
            _errorMessage = 'Connection error. Unable to reach the server.';
            break;
          case DioExceptionType.badCertificate:
            _errorMessage = 'Invalid SSL certificate.';
            break;
          case DioExceptionType.unknown:
          default:
            _errorMessage = 'Network error: ${e.message}';
            break;
        }
      });

      debugPrint('DioException: ${e.message}');
      debugPrint('Error Type: ${e.type}');
      debugPrint('Response: ${e.response?.toString()}');
      debugPrint('Request URL: ${e.requestOptions.uri}');
      debugPrint('Request Data: ${e.requestOptions.data}');
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Unexpected error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Theme(
      data: ThemeData(
        brightness: MediaQuery.of(context).platformBrightness,
        scaffoldBackgroundColor: isDarkMode ? AppColors.darkNeutral90 : AppColors.neutral10,
        appBarTheme: AppBarTheme(
          backgroundColor: isDarkMode ? AppColors.darkNeutral90 : AppColors.neutral10,
          foregroundColor: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
          elevation: 0,
          shadowColor: isDarkMode ? AppColors.darkNeutral30.withOpacity(0.3) : AppColors.neutral30.withOpacity(0.3),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
            borderSide: BorderSide(color: isDarkMode ? AppColors.darkNeutral30 : AppColors.neutral30),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
            borderSide: BorderSide(color: isDarkMode ? AppColors.darkNeutral30 : AppColors.neutral30),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
            borderSide: BorderSide(color: isDarkMode ? AppColors.darkPrimary : AppColors.primary, width: 2),
          ),
          filled: true,
          fillColor: isDarkMode ? AppColors.darkNeutral80.withOpacity(0.8) : AppColors.neutral20.withOpacity(0.8),
          labelStyle: AppTextStyles.captionRegular.copyWith(
            fontSize: Window.getFontSize(14),
            color: isDarkMode ? AppColors.darkNeutral40 : AppColors.neutral50,
          ),
          hintStyle: AppTextStyles.bodyRegular.copyWith(
            fontSize: Window.getFontSize(14),
            color: isDarkMode ? AppColors.darkNeutral40 : AppColors.neutral50,
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: isDarkMode ? AppColors.pureWhite : AppColors.neutral100,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Text to Image',
            style: AppTextStyles.titleBold.copyWith(
              fontSize: Window.getFontSize(20),
              color: isDarkMode ? AppColors.pureWhite : AppColors.neutral100,
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDarkMode
                    ? [AppColors.darkNeutral90 , AppColors.darkNeutral70,]
                    : [AppColors.pureWhite, AppColors.neutral10],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: Window.getSymmetricPadding(horizontal: 20, vertical: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Prompt Input
                  Text(
                    'Describe Your Vision',
                    style: AppTextStyles.titleBold.copyWith(
                      fontSize: Window.getFontSize(18),
                      color: isDarkMode ? AppColors.pureWhite : AppColors.neutral100,
                    ),
                  ),
                  SizedBox(height: Window.getVerticalSize(12)),
                  TextField(
                    controller: _promptController,
                    maxLines: 4,
                    style: AppTextStyles.bodyRegular.copyWith(
                      fontSize: Window.getFontSize(16),
                      color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
                    ),
                    decoration: InputDecoration(
                      hintText: 'e.g., A serene beach at sunset with vibrant colors',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
                      ),
                    ),
                  ),
                  SizedBox(height: Window.getVerticalSize(20)),

                  // Output Type and Dimensions
                  Row(
                    children: [
                      Expanded(
                        child: _buildSelector(
                          label: 'Output Type',
                          value: _selectedOutputType,
                          options: ['JPEG', 'PNG'],
                          onSelected: (value) {
                            setState(() {
                              _selectedOutputType = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: Window.getHorizontalSize(16)),
                      Expanded(
                        child: _buildSelector(
                          label: 'Dimensions',
                          value: _selectedDimension,
                          options: ['1:1 (Square)', '11:9 (Portrait)', '16:9 (Landscape)'],
                          onSelected: (value) {
                            setState(() {
                              _selectedDimension = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Window.getVerticalSize(20)),

                  // Style Selector
                  _buildSelector(
                    label: 'Style',
                    value: _selectedStyle,
                    options: [
                      'NONE (Default)',
                      'Pixar',
                      'Ghibli',
                      'Disney',
                      'Realistic',
                      'Anime',
                      'Watercolor',
                      'Oil Painting',
                      'Sketch',
                      'Comic',
                      '3D Render',
                      'Cyberpunk',
                      'Fantasy',
                      'Custom Style...'
                    ],
                    onSelected: (value) {
                      setState(() {
                        _selectedStyle = value;
                      });
                    },
                  ),
                  SizedBox(height: Window.getVerticalSize(20)),

                  // Seed Input
                  Text(
                    'Seed (Optional)',
                    style: AppTextStyles.captionBold.copyWith(
                      fontSize: Window.getFontSize(14),
                      color: isDarkMode ? AppColors.pureWhite : AppColors.neutral100,
                    ),
                  ),
                  SizedBox(height: Window.getVerticalSize(8)),
                  TextField(
                    controller: _seedController,
                    keyboardType: TextInputType.number,
                    style: AppTextStyles.bodyRegular.copyWith(
                      fontSize: Window.getFontSize(16),
                      color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter seed for consistent results',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
                      ),
                    ),
                  ),
                  SizedBox(height: Window.getVerticalSize(24)),

                  // Error Message
                  if (_errorMessage != null)
                    Padding(
                      padding: Window.getPadding(bottom: 16),
                      child: Text(
                        _errorMessage!,
                        style: AppTextStyles.bodyRegular.copyWith(
                          fontSize: Window.getFontSize(14),
                          color: isDarkMode ? AppColors.darkError60 : AppColors.error60,
                        ),
                      ),
                    ),

                  // Generate Button
                  Center(
                    child: CustomActionButton(
                      name: 'Generate Image',
                      isFormFilled: _promptController.text.trim().isNotEmpty,
                      isLoaded: !_isLoading,
                      onTap: (startLoading, stopLoading, btnState) async {
                        startLoading();
                        await _generateImage();
                        stopLoading();
                      },
                    ),
                  ),
                  SizedBox(height: Window.getVerticalSize(24)),

                  // Image Display Area
                  Container(
                    height: Window.getVerticalSize(300),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDarkMode ? AppColors.darkNeutral80.withOpacity(0.8) : AppColors.neutral20.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(Window.getRadiusSize(16)),
                      boxShadow: [
                        BoxShadow(
                          color: isDarkMode
                              ? AppColors.darkNeutral30.withOpacity(0.2)
                              : AppColors.neutral30.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                          color: isDarkMode
                              ? AppColors.darkNeutral30.withOpacity(0.5)
                              : AppColors.neutral30.withOpacity(0.5)),
                    ),
                    child: _generatedImageUrl != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(Window.getRadiusSize(16)),
                      child: Image.network(
                        _generatedImageUrl!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  isDarkMode ? AppColors.darkPrimary : AppColors.primary),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Text(
                              'Failed to load image',
                              style: AppTextStyles.bodyRegular.copyWith(
                                fontSize: Window.getFontSize(14),
                                color: isDarkMode ? AppColors.darkError60 : AppColors.error60,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                        : Center(
                      child: Text(
                        'Generated image will appear here',
                        style: AppTextStyles.bodyRegular.copyWith(
                          fontSize: Window.getFontSize(16),
                          color: isDarkMode ? AppColors.darkNeutral40 : AppColors.neutral50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelector({
    required String label,
    required String value,
    required List<String> options,
    required Function(String) onSelected,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.captionBold.copyWith(
            fontSize: Window.getFontSize(14),
            color: isDarkMode ? AppColors.pureWhite : AppColors.neutral100,
          ),
        ),
        SizedBox(height: Window.getVerticalSize(8)),
        GestureDetector(
          onTap: () {
            _showBottomSheetSelector(
              context: context,
              title: 'Select $label',
              options: options,
              selectedValue: value,
              onSelected: onSelected,
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
              border: Border.all(color: isDarkMode ? AppColors.darkNeutral30 : AppColors.neutral30),
              color: isDarkMode ? AppColors.darkNeutral80.withOpacity(0.8) : AppColors.neutral20.withOpacity(0.8),
              boxShadow: [
                BoxShadow(
                  color: isDarkMode ? AppColors.darkNeutral30.withOpacity(0.2) : AppColors.neutral30.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: AppTextStyles.bodyRegular.copyWith(
                    fontSize: Window.getFontSize(16),
                    color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: isDarkMode ? AppColors.darkNeutral40 : AppColors.neutral50,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showBottomSheetSelector({
    required BuildContext context,
    required String title,
    required List<String> options,
    required String selectedValue,
    required Function(String) onSelected,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: isDarkMode ? AppColors.darkNeutral90 : AppColors.neutral10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  title,
                  style: AppTextStyles.titleBold.copyWith(
                    fontSize: Window.getFontSize(18),
                    color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
                  ),
                ),
              ),
              Divider(color: isDarkMode ? AppColors.darkNeutral30.withOpacity(0.5) : AppColors.neutral30.withOpacity(0.5)),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: options.map((option) {
                    return ListTile(
                      title: Text(
                        option,
                        style: AppTextStyles.bodyRegular.copyWith(
                          fontSize: Window.getFontSize(16),
                          color: option == selectedValue
                              ? (isDarkMode ? AppColors.darkPrimary : AppColors.primary)
                              : (isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100),
                        ),
                      ),
                      trailing: option == selectedValue
                          ? Icon(Icons.check, color: isDarkMode ? AppColors.darkPrimary : AppColors.primary)
                          : null,
                      onTap: () {
                        onSelected(option);
                        Navigator.pop(context);
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: Window.getVerticalSize(16)),
            ],
          ),
        );
      },
    );
  }
}
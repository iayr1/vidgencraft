import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_textstyles.dart';
import '../../../../core/utils/windows.dart';
import '../../../../core/widgets/custom_action_button.dart';

class TextToVideoScreen extends StatefulWidget {
  const TextToVideoScreen({super.key});

  @override
  State<TextToVideoScreen> createState() => _TextToVideoScreenState();
}

class _TextToVideoScreenState extends State<TextToVideoScreen> {
  final TextEditingController _promptController = TextEditingController();
  int _selectedDuration = 5;
  bool _isLoading = false;
  String? _errorMessage;
  String? _generatedVideoUrl;
  final List<int> _durationOptions = List.generate(12, (index) => (index + 1) * 5); // 5, 10, ..., 60 seconds

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
    super.dispose();
  }

  Future<void> _generateVideo() async {
    if (_promptController.text.trim().isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a prompt';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _generatedVideoUrl = null;
    });

    try {
      debugPrint('Request URL: http://192.168.218.191:8001/text-segmentor');
      debugPrint('Request Data: ${{
        'text': _promptController.text,
        'video_length': _selectedDuration,
      }}');

      final response = await _dio.post(
        '/text-segmentor',
        data: {
          'text': _promptController.text,
          'video_length': _selectedDuration,
        },
      );

      final result = response.data;

      if (response.statusCode == 200 && result['success'] == true) {
        setState(() {
          _generatedVideoUrl = result['video_url'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = result['error'] ?? 'Failed to generate video';
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
    return Theme(
      data: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.neutral10,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.neutral10,
          foregroundColor: AppColors.neutral100,
          elevation: 0,
          shadowColor: AppColors.neutral30.withOpacity(0.3),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
            borderSide: BorderSide(color: AppColors.neutral30),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
            borderSide: BorderSide(color: AppColors.neutral30),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
          filled: true,
          fillColor: AppColors.neutral20.withOpacity(0.8),
          labelStyle: AppTextStyles.captionRegular.copyWith(
            fontSize: Window.getFontSize(14),
            color: AppColors.neutral50,
          ),
          hintStyle: AppTextStyles.bodyRegular.copyWith(
            fontSize: Window.getFontSize(14),
            color: AppColors.neutral50,
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Text to Video',
            style: AppTextStyles.titleBold.copyWith(
              fontSize: Window.getFontSize(20),
              color: AppColors.neutral100,
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary10, AppColors.neutral10],
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
                    'Describe Your Video',
                    style: AppTextStyles.titleBold.copyWith(
                      fontSize: Window.getFontSize(18),
                      color: AppColors.neutral100,
                    ),
                  ),
                  SizedBox(height: Window.getVerticalSize(12)),
                  TextField(
                    controller: _promptController,
                    maxLines: 4,
                    style: AppTextStyles.bodyRegular.copyWith(
                      fontSize: Window.getFontSize(16),
                      color: AppColors.neutral100,
                    ),
                    decoration: InputDecoration(
                      hintText: 'e.g., A vibrant scene of Avengers Endgame post-credit',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
                      ),
                    ),
                  ),
                  SizedBox(height: Window.getVerticalSize(20)),

                  // Duration Selector
                  _buildSelector(
                    label: 'Video Duration',
                    value: '$_selectedDuration seconds',
                    options: _durationOptions.map((e) => '$e seconds').toList(),
                    onSelected: (value) {
                      setState(() {
                        _selectedDuration = int.parse(value.split(' ')[0]);
                      });
                    },
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
                          color: AppColors.error60,
                        ),
                      ),
                    ),

                  // Generate Button
                  Center(
                    child: CustomActionButton(
                      name: 'Generate Video',
                      isFormFilled: _promptController.text.trim().isNotEmpty,
                      isLoaded: !_isLoading,
                      onTap: (startLoading, stopLoading, btnState) async {
                        startLoading();
                        await _generateVideo();
                        stopLoading();
                      },
                    ),
                  ),
                  SizedBox(height: Window.getVerticalSize(24)),

                  // Video Display Area
                  Container(
                    height: Window.getVerticalSize(300),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.neutral20.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(Window.getRadiusSize(16)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neutral30.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(color: AppColors.neutral30.withOpacity(0.5)),
                    ),
                    child: _generatedVideoUrl != null
                        ? Center(
                      child: Text(
                        'Video generated: $_generatedVideoUrl\n(Video playback requires additional setup)',
                        style: AppTextStyles.bodyRegular.copyWith(
                          fontSize: Window.getFontSize(14),
                          color: AppColors.neutral100,
                        ),
                      ),
                    )
                        : Center(
                      child: Text(
                        'Generated video will appear here',
                        style: AppTextStyles.bodyRegular.copyWith(
                          fontSize: Window.getFontSize(16),
                          color: AppColors.neutral50,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.captionBold.copyWith(
            fontSize: Window.getFontSize(14),
            color: AppColors.neutral100,
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
              border: Border.all(color: AppColors.neutral30),
              color: AppColors.neutral20.withOpacity(0.8),
              boxShadow: [
                BoxShadow(
                  color: AppColors.neutral30.withOpacity(0.2),
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
                    color: AppColors.neutral100,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.neutral50,
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
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.neutral10,
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
                    color: AppColors.neutral100,
                  ),
                ),
              ),
              Divider(color: AppColors.neutral30.withOpacity(0.5)),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: options.map((option) {
                    return ListTile(
                      title: Text(
                        option,
                        style: AppTextStyles.bodyRegular.copyWith(
                          fontSize: Window.getFontSize(16),
                          color: option == selectedValue ? AppColors.primary : AppColors.neutral100,
                        ),
                      ),
                      trailing: option == selectedValue
                          ? Icon(Icons.check, color: AppColors.primary)
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
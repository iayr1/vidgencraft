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


  @override
  Widget build(BuildContext context) {
    return Theme(
      // Use light theme with AppColors for consistency
      data: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.neutral10,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.neutral10,
          foregroundColor: AppColors.neutral100,
          elevation: 1,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.neutral10,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Window.getRadiusSize(8)),
          ),
          filled: true,
          fillColor: AppColors.neutral20,
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
            'Text to Image',
            style: AppTextStyles.titleBold.copyWith(
              fontSize: Window.getFontSize(18),
              color: AppColors.neutral100,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: Window.getPadding(all: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter your prompt',
                  style: AppTextStyles.titleBold.copyWith(
                    fontSize: Window.getFontSize(18),
                    color: AppColors.neutral100,
                  ),
                ),
                SizedBox(height: Window.getVerticalSize(8)),
                TextField(
                  controller: _promptController,
                  maxLines: 4,
                  style: AppTextStyles.bodyRegular.copyWith(
                    fontSize: Window.getFontSize(14),
                    color: AppColors.neutral100,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Describe the image you want to generate...',
                    hintStyle: AppTextStyles.bodyRegular.copyWith(
                      fontSize: Window.getFontSize(14),
                      color: AppColors.neutral50,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Window.getRadiusSize(8)),
                    ),
                  ),
                ),
                SizedBox(height: Window.getVerticalSize(16)),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Output Type',
                            style: AppTextStyles.captionBold.copyWith(
                              fontSize: Window.getFontSize(14),
                              color: AppColors.neutral100,
                            ),
                          ),
                          SizedBox(height: Window.getVerticalSize(4)),
                          GestureDetector(
                            onTap: () {
                              _showBottomSheetSelector(
                                context: context,
                                title: 'Select Output Type',
                                options: ['JPEG', 'PNG'],
                                selectedValue: _selectedOutputType,
                                onSelected: (value) {
                                  setState(() {
                                    _selectedOutputType = value;
                                  });
                                },
                              );
                            },
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'Output Type',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(Window.getRadiusSize(8)),
                                ),
                              ),
                              child: Text(
                                _selectedOutputType,
                                style: AppTextStyles.bodyRegular.copyWith(
                                  fontSize: Window.getFontSize(14),
                                  color: AppColors.neutral100,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: Window.getHorizontalSize(16)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dimensions',
                            style: AppTextStyles.captionBold.copyWith(
                              fontSize: Window.getFontSize(14),
                              color: AppColors.neutral100,
                            ),
                          ),
                          SizedBox(height: Window.getVerticalSize(4)),
                          DropdownButtonFormField<String>(
                            value: _selectedDimension,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(Window.getRadiusSize(8)),
                              ),
                            ),
                            dropdownColor: AppColors.neutral10,
                            items: [
                              '1:1 (Square)',
                              '11:9 (Portrait)',
                              '16:9 (Landscape)',
                            ]
                                .map((dim) => DropdownMenuItem(
                              value: dim,
                              child: Text(
                                dim,
                                style: AppTextStyles.bodyRegular.copyWith(
                                  fontSize: Window.getFontSize(14),
                                  color: AppColors.neutral100,
                                ),
                              ),
                            ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedDimension = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Window.getVerticalSize(16)),
                Text(
                  'Style',
                  style: AppTextStyles.captionBold.copyWith(
                    fontSize: Window.getFontSize(14),
                    color: AppColors.neutral100,
                  ),
                ),
                SizedBox(height: Window.getVerticalSize(4)),
                DropdownButtonFormField<String>(
                  value: _selectedStyle,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Window.getRadiusSize(8)),
                    ),
                  ),
                  dropdownColor: AppColors.neutral10,
                  items: [
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
                  ]
                      .map((style) => DropdownMenuItem(
                    value: style,
                    child: Text(
                      style,
                      style: AppTextStyles.bodyRegular.copyWith(
                        fontSize: Window.getFontSize(14),
                        color: AppColors.neutral100,
                      ),
                    ),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedStyle = value!;
                    });
                  },
                ),
                SizedBox(height: Window.getVerticalSize(16)),
                Text(
                  'Seed (Optional)',
                  style: AppTextStyles.captionBold.copyWith(
                    fontSize: Window.getFontSize(14),
                    color: AppColors.neutral100,
                  ),
                ),
                SizedBox(height: Window.getVerticalSize(4)),
                TextField(
                  controller: _seedController,
                  style: AppTextStyles.bodyRegular.copyWith(
                    fontSize: Window.getFontSize(14),
                    color: AppColors.neutral100,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Leave empty for random results...',
                    hintStyle: AppTextStyles.bodyRegular.copyWith(
                      fontSize: Window.getFontSize(14),
                      color: AppColors.neutral50,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Window.getRadiusSize(8)),
                    ),
                  ),
                ),
                SizedBox(height: Window.getVerticalSize(16)),
                Center(
                  child: CustomActionButton(
                    name: 'Generate Image',
                    isFormFilled: _promptController.text.trim().isNotEmpty, // check if form is filled
                    onTap: (startLoading, stopLoading, btnState) async {
                        startLoading();
                        // TODO: Implement image generation logic here
                        await Future.delayed(const Duration(seconds: 2)); // Simulate a delay
                        stopLoading();
                      }
                  ),
                ),
                SizedBox(height: Window.getVerticalSize(16)),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.neutral20,
                      borderRadius: BorderRadius.circular(Window.getRadiusSize(8)),
                    ),
                    child: Center(
                      child: Text(
                        'Generated image will appear here',
                        style: AppTextStyles.bodyRegular.copyWith(
                          fontSize: Window.getFontSize(14),
                          color: AppColors.neutral50,
                        ),
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


  void _showBottomSheetSelector({
    required BuildContext context,
    required String title,
    required List<String> options,
    required String selectedValue,
    required Function(String) onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  title,
                  style: AppTextStyles.titleBold.copyWith(
                    fontSize: Window.getFontSize(16),
                    color: AppColors.neutral100,
                  ),
                ),
              ),
              ...options.map((option) {
                return ListTile(
                  title: Text(
                    option,
                    style: AppTextStyles.bodyRegular.copyWith(
                      fontSize: Window.getFontSize(14),
                      color: option == selectedValue
                          ? AppColors.primary
                          : AppColors.neutral100,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    onSelected(option);
                  },
                );
              }).toList(),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

}
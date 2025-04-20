import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_textstyles.dart';
import '../../../../core/utils/windows.dart';


class TextToVideoScreen extends StatefulWidget {
  const TextToVideoScreen({super.key});

  @override
  State<TextToVideoScreen> createState() => _TextToVideoScreenState();
}

class _TextToVideoScreenState extends State<TextToVideoScreen> {

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
            'Text to Video',
            style: AppTextStyles.titleBold.copyWith(
              fontSize: Window.getFontSize(18),
              color: AppColors.neutral100,
            ),
          ),
        ),
        body: Padding(
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
              SizedBox(height: Window.getVerticalSize(10)),
              TextField(
                maxLines: 3,
                style: AppTextStyles.bodyRegular.copyWith(
                  fontSize: Window.getFontSize(14),
                  color: AppColors.neutral100,
                ),
                decoration: InputDecoration(
                  hintText: 'Create a beautiful video of Avengers Endgame post-credit scene',
                  hintStyle: AppTextStyles.bodyRegular.copyWith(
                    fontSize: Window.getFontSize(14),
                    color: AppColors.neutral50,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Window.getRadiusSize(8)),
                  ),
                ),
              ),
              SizedBox(height: Window.getVerticalSize(20)),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: 5,
                      decoration: InputDecoration(
                        labelText: 'Video Duration (Seconds)',
                        labelStyle: AppTextStyles.captionRegular.copyWith(
                          fontSize: Window.getFontSize(14),
                          color: AppColors.neutral50,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Window.getRadiusSize(8)),
                        ),
                      ),
                      dropdownColor: AppColors.neutral20,
                      items: List.generate(12, (index) => (index + 1) * 5) // 5, 10, 15, ..., 60 seconds
                          .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          '$e seconds',
                          style: AppTextStyles.bodyRegular.copyWith(
                            fontSize: Window.getFontSize(14),
                            color: AppColors.neutral100,
                          ),
                        ),
                      ))
                          .toList(),
                      onChanged: (value) {
                        // TODO: Handle video duration selection
                      },
                    ),
                  ),
                  SizedBox(width: Window.getHorizontalSize(10)),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement video generation logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: Window.getSymmetricPadding(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Window.getRadiusSize(8)),
                      ),
                    ),
                    child: Text(
                      'Generate',
                      style: AppTextStyles.bodyBold.copyWith(
                        fontSize: Window.getFontSize(14),
                        color: AppColors.neutral10,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
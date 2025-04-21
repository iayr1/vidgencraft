import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vidgencraft/core/constants/app_colors.dart';
import 'package:vidgencraft/core/constants/app_textstyles.dart';
import 'package:vidgencraft/core/utils/windows.dart';
import 'package:vidgencraft/core/widgets/custom_action_button.dart';

class ImageToVideoScreen extends StatefulWidget {
  const ImageToVideoScreen({super.key});

  @override
  State<ImageToVideoScreen> createState() => _ImageToVideoScreenState();
}

class _ImageToVideoScreenState extends State<ImageToVideoScreen> with SingleTickerProviderStateMixin {
  String? selectedExpression;
  String? selectedBackground;
  String selectedModel = 'Kling';
  File? _selectedImage; // Store the selected image file
  final ImagePicker _picker = ImagePicker(); // Image picker instance
  final List<String> expressions = [
    '😂 Laughing',
    '😭 Crying',
    '🤗 Hugging',
    '🎤 Singing',
    '🗣️ Talking',
    '💋 Kissing',
    '🏃 Running',
    '🤸 Jumping',
    '🤝 Handshake',
    '💃 Dancing',
    '😊 Smiling',
    '🚶 Walking',
  ];
  final List<String> backgroundImages = [
    'assets/photos/Wooden.png',
    'assets/photos/Wedding.png',
    'assets/photos/Neon.png',
    'assets/photos/Natural.png',
    'assets/photos/Marble.png',
    'assets/photos/Living.png',
    'assets/photos/Kitchen.png',
    'assets/photos/greywall.png',
    'assets/photos/Generic.png',
  ];
  final List<String> models = ['Kling', 'Minimax', 'Veo2'];
  final TextEditingController _descriptionController = TextEditingController();
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _descriptionController.dispose();
    super.dispose();
  }


  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1024, // Optimize for performance
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  // Show bottom sheet to choose between gallery and camera
  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Select Image Source',
                  style: AppTextStyles.titleBold.copyWith(
                    fontSize: Window.getFontSize(18),
                    color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: isDarkMode ? AppColors.darkPrimary : AppColors.primary,
                ),
                title: Text(
                  'Gallery',
                  style: AppTextStyles.bodyRegular.copyWith(
                    fontSize: Window.getFontSize(16),
                    color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.camera_alt,
                  color: isDarkMode ? AppColors.darkPrimary : AppColors.primary,
                ),
                title: Text(
                  'Camera',
                  style: AppTextStyles.bodyRegular.copyWith(
                    fontSize: Window.getFontSize(16),
                    color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              SizedBox(height: Window.getVerticalSize(16)),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

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
            'Image to Video',
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
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            padding: Window.getSymmetricPadding(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Upload Section
                Text(
                  'Upload Image',
                  style: AppTextStyles.titleBold.copyWith(
                    fontSize: Window.getFontSize(18),
                    color: isDarkMode ? AppColors.pureWhite : AppColors.neutral100,
                  ),
                ),
                SizedBox(height: Window.getVerticalSize(12)),
                GestureDetector(
                  onTap: _showImageSourceOptions,
                  child: Container(
                    height: Window.getVerticalSize(200),
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
                            : AppColors.neutral30.withOpacity(0.5),
                      ),
                    ),
                    child: _selectedImage != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(Window.getRadiusSize(16)),
                      child: Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    )
                        : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            color: isDarkMode ? AppColors.darkNeutral40 : AppColors.neutral50,
                            size: 50,
                          ),
                          SizedBox(height: Window.getVerticalSize(8)),
                          Text(
                            'Tap to select image',
                            style: AppTextStyles.bodyRegular.copyWith(
                              fontSize: Window.getFontSize(14),
                              color: isDarkMode ? AppColors.darkNeutral40 : AppColors.neutral50,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Window.getVerticalSize(16)),
                CustomActionButton(
                  name: 'Upload Image',
                  isFormFilled: true,
                  isLoaded: true,
                  onTap: (startLoading, stopLoading, btnState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Image upload clicked')),
                    );
                  },
                ),
                SizedBox(height: Window.getVerticalSize(24)),

                // Expression Selection
                Text(
                  'Choose an Expression',
                  style: AppTextStyles.titleBold.copyWith(
                    fontSize: Window.getFontSize(18),
                    color: isDarkMode ? AppColors.pureWhite : AppColors.neutral100,
                  ),
                ),
                SizedBox(height: Window.getVerticalSize(12)),
                SizedBox(
                  height: Window.getVerticalSize(50),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: expressions.length,
                    itemBuilder: (context, index) {
                      final expression = expressions[index];
                      final isSelected = selectedExpression == expression;
                      return Padding(
                        padding: Window.getPadding(right: 12),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedExpression = expression;
                            });
                          },
                          child: Container(
                            padding: Window.getSymmetricPadding(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? (isDarkMode ? AppColors.darkPrimary90 : AppColors.primary90)
                                  : (isDarkMode ? AppColors.darkNeutral80 : AppColors.neutral30),
                              borderRadius: BorderRadius.circular(Window.getRadiusSize(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: isDarkMode
                                      ? AppColors.darkNeutral30.withOpacity(0.2)
                                      : AppColors.neutral30.withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                expression,
                                style: AppTextStyles.subtitleSemiBold.copyWith(
                                  color: isSelected
                                      ? (isDarkMode ? AppColors.darkNeutral90 : AppColors.neutral10)
                                      : (isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100),
                                  fontSize: Window.getFontSize(14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: Window.getVerticalSize(24)),

                // Background Selection
                Text(
                  'Choose Background',
                  style: AppTextStyles.titleBold.copyWith(
                    fontSize: Window.getFontSize(18),
                    color: isDarkMode ? AppColors.pureWhite : AppColors.neutral100,
                  ),
                ),
                SizedBox(height: Window.getVerticalSize(12)),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: Window.getHorizontalSize(12),
                    mainAxisSpacing: Window.getVerticalSize(12),
                    childAspectRatio: 1,
                  ),
                  itemCount: backgroundImages.length,
                  itemBuilder: (context, index) {
                    final imagePath = backgroundImages[index];
                    final isSelected = selectedBackground == imagePath;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedBackground = imagePath;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
                          border: Border.all(
                            color: isSelected
                                ? (isDarkMode ? AppColors.darkPrimary : AppColors.primary)
                                : (isDarkMode
                                ? AppColors.darkNeutral30.withOpacity(0.5)
                                : AppColors.neutral30.withOpacity(0.5)),
                            width: isSelected ? 3 : 1,
                          ),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Stack(
                          children: [
                            Image.asset(
                              imagePath,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            if (isSelected)
                              Positioned(
                                top: 6,
                                right: 6,
                                child: Icon(
                                  Icons.check_circle,
                                  color: isDarkMode ? AppColors.darkPrimary : AppColors.primary,
                                  size: 20,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: Window.getVerticalSize(24)),

                // Description Input
                Text(
                  'Describe Your Video',
                  style: AppTextStyles.titleBold.copyWith(
                    fontSize: Window.getFontSize(18),
                    color: isDarkMode ? AppColors.pureWhite : AppColors.neutral100,
                  ),
                ),
                SizedBox(height: Window.getVerticalSize(12)),
                TextField(
                  controller: _descriptionController,
                  maxLines: 4,
                  style: AppTextStyles.bodyRegular.copyWith(
                    fontSize: Window.getFontSize(16),
                    color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
                  ),
                  decoration: InputDecoration(
                    hintText: 'e.g., A character dancing in a vibrant city',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
                    ),
                  ),
                ),
                SizedBox(height: Window.getVerticalSize(24)),

                // Model Selection
                _buildSelector(
                  label: 'Model',
                  value: selectedModel,
                  options: models,
                  onSelected: (value) {
                    setState(() {
                      selectedModel = value;
                    });
                  },
                ),
                SizedBox(height: Window.getVerticalSize(24)),

                // Generate Video Button
                Center(
                  child: CustomActionButton(
                    name: 'Generate Video',
                    isFormFilled: _descriptionController.text.trim().isNotEmpty,
                    isLoaded: true,
                    onTap: (startLoading, stopLoading, btnState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Generate Video clicked')),
                      );
                    },
                  ),
                ),
              ],
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
                  color: isDarkMode
                      ? AppColors.darkNeutral30.withOpacity(0.2)
                      : AppColors.neutral30.withOpacity(0.2),
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

  Widget _buildSmallButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: Window.getSymmetricPadding(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isDarkMode ? AppColors.darkNeutral80 : AppColors.neutral20,
          borderRadius: BorderRadius.circular(Window.getRadiusSize(8)),
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? AppColors.darkNeutral30.withOpacity(0.2) : AppColors.neutral30.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          text,
          style: AppTextStyles.subtitleRegular.copyWith(
            color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
            fontSize: Window.getFontSize(14),
          ),
        ),
      ),
    );
  }
}
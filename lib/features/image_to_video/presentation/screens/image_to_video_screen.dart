import 'package:flutter/material.dart';
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
    Window().adaptDeviceScreenSize(view: WidgetsBinding.instance.platformDispatcher.views.first);
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

  @override
  Widget build(BuildContext context) {
    // Set the theme for AppColors

    return Theme(
      data: ThemeData(
        // Use system brightness
        brightness: MediaQuery.of(context).platformBrightness,
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
            'Image to Video',
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
                    color: AppColors.neutral100,
                  ),
                ),
                SizedBox(height: Window.getVerticalSize(12)),
                Container(
                  height: Window.getVerticalSize(200),
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
                  child: Center(
                    child: Icon(
                      Icons.image,
                      color: AppColors.neutral50,
                      size: 50,
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
                    color: AppColors.neutral100,
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
                              color: isSelected ? AppColors.primary90 : AppColors.neutral30,
                              borderRadius: BorderRadius.circular(Window.getRadiusSize(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.neutral30.withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                expression,
                                style: AppTextStyles.subtitleSemiBold.copyWith(
                                  color: isSelected ? AppColors.neutral10 : AppColors.neutral100,
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
                    color: AppColors.neutral100,
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
                            color: isSelected ? AppColors.primary : AppColors.neutral30.withOpacity(0.5),
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
                                  color: AppColors.primary,
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
                    color: AppColors.neutral100,
                  ),
                ),
                SizedBox(height: Window.getVerticalSize(12)),
                TextField(
                  controller: _descriptionController,
                  maxLines: 4,
                  style: AppTextStyles.bodyRegular.copyWith(
                    fontSize: Window.getFontSize(16),
                    color: AppColors.neutral100,
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

  Widget _buildSmallButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: Window.getSymmetricPadding(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.neutral20,
          borderRadius: BorderRadius.circular(Window.getRadiusSize(8)),
          boxShadow: [
            BoxShadow(
              color: AppColors.neutral30.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          text,
          style: AppTextStyles.subtitleRegular.copyWith(
            color: AppColors.neutral100,
            fontSize: Window.getFontSize(14),
          ),
        ),
      ),
    );
  }
}

class ScaleTransitionButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;

  const ScaleTransitionButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  _ScaleTransitionButtonState createState() => _ScaleTransitionButtonState();
}

class _ScaleTransitionButtonState extends State<ScaleTransitionButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}
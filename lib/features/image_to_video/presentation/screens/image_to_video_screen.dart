import 'package:flutter/material.dart';
import 'package:vidgencraft/core/constants/app_colors.dart';
import 'package:vidgencraft/core/constants/app_textstyles.dart';
import 'package:vidgencraft/core/utils/windows.dart';

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
    'Laughing',
    'Crying',
    'Hugging',
    'Singing',
    'Talking',
    'Kissing',
    'Running',
    'Jumping',
    'Handshake',
    'Dancing',
    'Smiling',
    'Walking',
  ];
  final List<String> backgroundImages = [
    'wood.jpg',
    'window.jpg',
    'city.jpg',
    'marble.jpg',
    'plants.jpg',
    'kitchen.jpg',
    'gradient.jpg',
    'tulips.jpg',
    'grey.jpg',
  ];
  final List<String> models = ['Kling', 'Minimax', 'Veo2'];
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize Window for responsive sizing
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Theme(
      data: ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        scaffoldBackgroundColor: isDarkMode ? AppColors.darkNeutral100 : AppColors.neutral10,
        appBarTheme: AppBarTheme(
          backgroundColor: isDarkMode ? AppColors.darkNeutral80 : AppColors.neutral20,
          foregroundColor: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
          elevation: 0,
        ),
        cardColor: isDarkMode ? AppColors.darkNeutral80 : AppColors.neutral20,
        textTheme: TextTheme(
          bodyMedium: AppTextStyles.bodyRegular.copyWith(
            color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
            fontSize: Window.getFontSize(14),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: isDarkMode ? AppColors.darkNeutral70 : AppColors.neutral30,
          hintStyle: AppTextStyles.subtitleRegular.copyWith(
            color: isDarkMode ? AppColors.darkNeutral10.withOpacity(0.5) : AppColors.neutral100.withOpacity(0.5),
            fontSize: Window.getFontSize(14),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
            borderSide: BorderSide(color: isDarkMode ? AppColors.darkNeutral50 : AppColors.neutral50),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
            borderSide: BorderSide(color: isDarkMode ? AppColors.darkNeutral50 : AppColors.neutral50),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
            borderSide: BorderSide(
              color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
              width: 2,
            ),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Image to Video',
            style: AppTextStyles.heading4Bold.copyWith(
              color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
              fontSize: Window.getFontSize(20),
            ),
          ),
        ),
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            padding: Window.getPadding(all: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Upload Section
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Window.getRadiusSize(16)),
                  ),
                  child: Padding(
                    padding: Window.getPadding(all: 16),
                    child: Column(
                      children: [
                        Container(
                          height: Window.getVerticalSize(150) ?? 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isDarkMode ? AppColors.darkNeutral70 : AppColors.neutral30,
                            borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
                            border: Border.all(
                              color: isDarkMode ? AppColors.darkNeutral50.withOpacity(0.3) : AppColors.neutral50.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.image,
                            color: isDarkMode ? AppColors.darkNeutral10.withOpacity(0.7) : AppColors.neutral100.withOpacity(0.7),
                            size: 50,
                          ),
                        ),
                        SizedBox(height: Window.getVerticalSize(12) ?? 12),
                        ScaleTransitionButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Image upload clicked')),
                            );
                          },
                          child: Container(
                            padding: Window.getSymmetricPadding(horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              color: isDarkMode ? AppColors.darkNeutral50 : AppColors.neutral70,
                              borderRadius: BorderRadius.circular(Window.getRadiusSize(30)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.upload,
                                  color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral10,
                                  size: Window.getSize(20),
                                ),
                                SizedBox(width: Window.getHorizontalSize(8) ?? 8),
                                Text(
                                  'Upload Image',
                                  style: AppTextStyles.subtitleBold.copyWith(
                                    color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral10,
                                    fontSize: Window.getFontSize(16) ?? 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Window.getVerticalSize(12) ?? 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ScaleTransitionButton(
                              onPressed: () {},
                              child: Container(
                                padding: Window.getSymmetricPadding(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isDarkMode ? AppColors.darkNeutral60 : AppColors.neutral40,
                                  borderRadius: BorderRadius.circular(Window.getRadiusSize(8)),
                                ),
                                child: Text(
                                  'Image 1',
                                  style: AppTextStyles.subtitleRegular.copyWith(
                                    color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
                                    fontSize: Window.getFontSize(14) ?? 14,
                                  ),
                                ),
                              ),
                            ),
                            ScaleTransitionButton(
                              onPressed: () {},
                              child: Container(
                                padding: Window.getSymmetricPadding(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isDarkMode ? AppColors.darkNeutral60 : AppColors.neutral40,
                                  borderRadius: BorderRadius.circular(Window.getRadiusSize(8)),
                                ),
                                child: Text(
                                  'Image 2',
                                  style: AppTextStyles.subtitleRegular.copyWith(
                                    color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
                                    fontSize: Window.getFontSize(14) ?? 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Window.getVerticalSize(12) ?? 12),
                        ScaleTransitionButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Process Images clicked')),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: Window.getSymmetricPadding(vertical: 12),
                            decoration: BoxDecoration(
                              color: isDarkMode ? AppColors.darkNeutral50 : AppColors.neutral70,
                              borderRadius: BorderRadius.circular(Window.getRadiusSize(8)),
                            ),
                            child: Center(
                              child: Text(
                                'Process Images',
                                style: AppTextStyles.subtitleBold.copyWith(
                                  color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral10,
                                  fontSize: Window.getFontSize(16) ?? 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Window.getVerticalSize(24)),

                // Expression Selection
                Text(
                  'Choose an Expression',
                  style: AppTextStyles.heading5Bold.copyWith(
                    color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
                    fontSize: Window.getFontSize(20),
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
                        child: ScaleTransitionButton(
                          onPressed: () {
                            setState(() {
                              selectedExpression = expression;
                            });
                          },
                          child: Container(
                            padding: Window.getSymmetricPadding(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? (isDarkMode ? AppColors.darkNeutral50 : AppColors.neutral70)
                                  : (isDarkMode ? AppColors.darkNeutral60 : AppColors.neutral40),
                              borderRadius: BorderRadius.circular(Window.getRadiusSize(20)),
                              boxShadow: isSelected
                                  ? [
                                BoxShadow(
                                  color: isDarkMode
                                      ? AppColors.darkNeutral50.withOpacity(0.3)
                                      : AppColors.neutral50.withOpacity(0.3),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ]
                                  : [],
                            ),
                            child: Center(
                              child: Text(
                                expression,
                                style: AppTextStyles.subtitleSemiBold.copyWith(
                                  color: isSelected
                                      ? (isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral10)
                                      : (isDarkMode
                                      ? AppColors.darkNeutral10.withOpacity(0.7)
                                      : AppColors.neutral100.withOpacity(0.7)),
                                  fontSize: Window.getFontSize(14) ?? 14,
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
                  style: AppTextStyles.heading5Bold.copyWith(
                    color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
                    fontSize: Window.getFontSize(20),
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
                    final background = backgroundImages[index];
                    final isSelected = selectedBackground == background;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedBackground = background;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: isDarkMode ? AppColors.darkNeutral60 : AppColors.neutral40,
                          borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
                          border: isSelected
                              ? Border.all(
                            color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
                            width: 3,
                          )
                              : null,
                          boxShadow: isSelected
                              ? [
                            BoxShadow(
                              color: isDarkMode
                                  ? AppColors.darkNeutral50.withOpacity(0.3)
                                  : AppColors.neutral50.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ]
                              : [],
                        ),
                        child: Center(
                          child: Text(
                            background.split('.').first,
                            style: AppTextStyles.subtitleRegular.copyWith(
                              color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
                              fontSize: Window.getFontSize(12) ?? 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: Window.getVerticalSize(24)),

                // Description Input
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Describe the video you want to generate...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
                    ),
                  ),
                  maxLines: 4,
                  style: AppTextStyles.subtitleRegular.copyWith(
                    color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
                    fontSize: Window.getFontSize(14) ?? 14,
                  ),
                ),
                SizedBox(height: Window.getVerticalSize(24)),

                // Model Selection
                Container(
                  padding: Window.getSymmetricPadding(horizontal: 16),
                  decoration: BoxDecoration(
                    color: isDarkMode ? AppColors.darkNeutral50 : AppColors.neutral70,
                    borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
                  ),
                  child: DropdownButton<String>(
                    value: selectedModel,
                    isExpanded: true,
                    underline: const SizedBox(),
                    dropdownColor: isDarkMode ? AppColors.darkNeutral80 : AppColors.neutral20,
                    items: models.map((model) {
                      return DropdownMenuItem(
                        value: model,
                        child: Text(
                          model,
                          style: AppTextStyles.subtitleSemiBold.copyWith(
                            color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
                            fontSize: Window.getFontSize(16),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedModel = value!;
                      });
                    },
                  ),
                ),
                SizedBox(height: Window.getVerticalSize(24)),

                // Generate Video Button
                ScaleTransitionButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Generate Video clicked')),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: Window.getSymmetricPadding(vertical: 16),
                    decoration: BoxDecoration(
                      color: isDarkMode ? AppColors.darkNeutral50 : AppColors.neutral70,
                      borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
                      boxShadow: [
                        BoxShadow(
                          color: isDarkMode ? AppColors.darkNeutral50.withOpacity(0.3) : AppColors.neutral50.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Generate Video',
                        style: AppTextStyles.subtitleBold.copyWith(
                          color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral10,
                          fontSize: Window.getFontSize(18),
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
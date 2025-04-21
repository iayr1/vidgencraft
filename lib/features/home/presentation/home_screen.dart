import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vidgencraft/features/image_to_video/presentation/screens/image_to_video_screen.dart';
import 'package:vidgencraft/features/text_to_image/presentation/screens/text_to_image_screen.dart';
import 'package:vidgencraft/features/text_to_video/presentation/screens/text_to_video_screen.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_textstyles.dart';
import '../../../core/widgets/custom_action_button.dart';
import '../../profile/presentation/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )
      ..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme
        .of(context)
        .brightness == Brightness.dark;
    final backgroundColorStart = isDarkMode
        ? AppColors.darkNeutral90
        : AppColors.neutral10;
    final backgroundColorEnd = isDarkMode ? AppColors.darkNeutral80 : Colors
        .blueGrey[50]!;
    final textColor = isDarkMode ? AppColors.darkNeutral20 : AppColors
        .neutral80;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [backgroundColorStart, backgroundColorEnd],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 24.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section
                    _buildHeaderSection(context, isDarkMode, textColor)
                        .animate()
                        .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                        .slideY(begin: 0.2, end: 0),
                    const SizedBox(height: 24),

                    // Main Actions Section
                    _buildMainActionsSection(context, isDarkMode),
                    const SizedBox(height: 32),
                    // Upgrade Plan Section
                    _buildUpgradePlanSection(context, isDarkMode, textColor)
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 400.ms)
                        .scale(curve: Curves.easeOut),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, bool isDarkMode,
      Color textColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome',
                style: AppTextStyles.subtitleBold.copyWith(
                  color: isDarkMode ? AppColors.neutral10 : textColor,
                  fontSize: 22,
                  letterSpacing: 0.5,
                  height: 1.3,
                ),
              ),
              Text(
                'Mayur',
                style: AppTextStyles.titleBold.copyWith(
                  color: isDarkMode ? AppColors.neutral10 : textColor,
                  fontSize: 26,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Create stunning videos today',
                style: AppTextStyles.bodyRegular.copyWith(
                  color: isDarkMode ? AppColors.neutral40 : AppColors.neutral60,
                  fontSize: 14,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.settings,
            size: 26,
            color: isDarkMode ? AppColors.primary : AppColors.neutral100,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProfilePageWrapper()),
            );
          },
        ),
      ],
    );
  }


  Widget _buildMainActionsSection(BuildContext context, bool isDarkMode) {
    final titleColor = isDarkMode ? Colors.white : AppColors.neutral100;
    final subtitleColor = isDarkMode ? AppColors.neutral30 : AppColors
        .neutral70;

    return Row(
      children: [
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Your Content',
                style: AppTextStyles.heading4Bold.copyWith(
                  color: titleColor,
                  fontSize: 22,
                  letterSpacing: 0.4,
                ),
              ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1, end: 0),
              const SizedBox(height: 8),
              Text(
                'Choose from one of the options below',
                style: AppTextStyles.bodyRegular.copyWith(
                  fontSize: 14,
                  color: subtitleColor,
                  letterSpacing: 0.2,
                ),
              ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1, end: 0),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildActionCard(
                    context,
                    title: 'Image to Video',
                    imagePath: 'assets/1.png',
                    onTap: () =>
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ImageToVideoScreen()),
                        ),
                  ).animate().fadeIn(duration: 600.ms, delay: 100.ms).scale(),

                  _buildActionCard(
                    context,
                    title: 'Text to Video',
                    imagePath: 'assets/2.png',
                    onTap: () =>
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const TextToVideoScreen()),
                        ),
                  ).animate().fadeIn(duration: 600.ms, delay: 200.ms).scale(),

                  _buildActionCard(
                    context,
                    title: 'Text to Image',
                    imagePath: 'assets/3.png',
                    onTap: () =>
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const TextToImageScreen()),
                        ),
                  ).animate().fadeIn(duration: 600.ms, delay: 300.ms).scale(),

                  _buildActionCard(
                    context,
                    title: 'Library',
                    imagePath: 'assets/4.png',
                    onTap: () {
                      // TODO: Implement navigation
                    },
                  ).animate().fadeIn(duration: 600.ms, delay: 400.ms).scale(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }


  Widget _buildUpgradePlanSection(BuildContext context, bool isDarkMode,
      Color textColor) {
    return Row(
      children: [
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDarkMode
                        ? [
                      AppColors.darkNeutral70.withOpacity(0.95),
                      AppColors.darkNeutral60.withOpacity(0.95),
                    ]
                        : [
                      const Color(0xFFF9FAFB),
                      const Color(0xFFE8EDF1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode ? Colors.black.withOpacity(0.3) : Colors
                          .grey.withOpacity(0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '✨ Premium Features',
                      style: AppTextStyles.subtitleBold.copyWith(
                        fontSize: 20,
                        color: isDarkMode ? AppColors.neutral10 : textColor,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Unlock unlimited video generations, HD quality,\nand priority support with our Pro plan.',
                      style: AppTextStyles.bodyRegular.copyWith(
                        color: isDarkMode ? AppColors.neutral30 : AppColors.neutral70,
                        fontSize: 14,
                        height: 1.5,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 200.0,
                        minHeight: 48.0,
                      ),
                      child: CustomActionButton(
                        name: 'Upgrade Now',
                        isFormFilled: true,
                        buttonHeight: 56,
                        isWhiteThemed: !isDarkMode,
                        isOutlined: false,
                        buttonWidth: 350,
                        onTap: (startLoading, stopLoading, btnState) async {
                          startLoading();
                          await Future.delayed(const Duration(seconds: 1));
                          stopLoading();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  Widget _buildActionCard(BuildContext context, {
    required String title,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    final isDarkMode = Theme
        .of(context)
        .brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          gradient: LinearGradient(
            colors: isDarkMode
                ? [
              AppColors.darkNeutral80.withOpacity(0.8),
              AppColors.darkNeutral70.withOpacity(0.8)
            ]
                : [Colors.white, Colors.blueGrey[50]!],
          ),
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? Colors.black26 : Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    imagePath,
                    height: 48,
                    width: 48,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: AppTextStyles.subtitleSemiBold.copyWith(
                      color: isDarkMode ? Colors.white : AppColors.neutral100,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
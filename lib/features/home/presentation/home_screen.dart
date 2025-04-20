import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vidgencraft/features/image_to_video/presentation/screens/image_to_video_screen.dart';
import 'package:vidgencraft/features/text_to_image/presentation/screens/text_to_image_screen.dart';
import 'package:vidgencraft/features/text_to_video/presentation/screens/text_to_video_screen.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_textstyles.dart';
import '../../../core/utils/windows.dart';
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
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColorStart = isDarkMode ? AppColors.darkNeutral90 : AppColors.neutral10;
    final backgroundColorEnd = isDarkMode ? AppColors.darkNeutral80 : AppColors.neutral20;
    final textColor = isDarkMode ? AppColors.darkNeutral20 : AppColors.neutral80;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [backgroundColorStart, backgroundColorEnd],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section (Unchanged)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isDarkMode
                            ? [AppColors.darkNeutral80, AppColors.darkNeutral70]
                            : [AppColors.neutral20, AppColors.neutral30],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: isDarkMode
                                  ? [AppColors.darkNeutral60, AppColors.darkNeutral50]
                                  : [AppColors.neutral30, AppColors.neutral40],
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              size: 30,
                              color: AppColors.neutral10,
                            ),
                          ),
                        )
                            .animate(controller: _animationController)
                            .fadeIn()
                            .scale(delay: const Duration(milliseconds: 100)),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome, John!',
                              style: AppTextStyles.subtitleBold.copyWith(
                                color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
                              ),
                            )
                                .animate(controller: _animationController)
                                .fadeIn(delay: const Duration(milliseconds: 200)),
                            Text(
                              'Create stunning videos today',
                              style: AppTextStyles.bodyRegular.copyWith(
                                color: textColor,
                              ),
                            )
                                .animate(controller: _animationController)
                                .fadeIn(delay: const Duration(milliseconds: 300)),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: isDarkMode ? AppColors.darkPrimary : AppColors.primary,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfilePageWrapper(),
                              ),
                            );
                          },
                        )
                            .animate(controller: _animationController)
                            .fadeIn(delay: const Duration(milliseconds: 400))
                            .scale(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Main Actions Section (Updated)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create Your Content',
                          style: AppTextStyles.heading4Bold.copyWith(
                            color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
                          ),
                        )
                            .animate(controller: _animationController)
                            .fadeIn(delay: const Duration(milliseconds: 500))
                            .slideX(begin: -0.2, end: 0),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: _buildActionCard(
                                context,
                                title: 'Image to Video',
                                imagePath: 'assets/1.png',
                                color: AppColors.neutral10,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const ImageToVideoScreen()),
                                  );
                                },
                              )
                                  .animate(controller: _animationController)
                                  .fadeIn(delay: const Duration(milliseconds: 600))
                                  .scale(),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: _buildActionCard(
                                context,
                                title: 'Text to Video',
                                imagePath: 'assets/2.png',
                                color: AppColors.neutral10,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const TextToVideoScreen()),
                                  );
                                },
                              )
                                  .animate(controller: _animationController)
                                  .fadeIn(delay: const Duration(milliseconds: 700))
                                  .scale(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: _buildActionCard(
                                context,
                                title: 'Text to Image',
                                imagePath: 'assets/3.png',
                                color: AppColors.neutral10,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const TextToImageScreen()),
                                  );
                                },
                              )
                                  .animate(controller: _animationController)
                                  .fadeIn(delay: const Duration(milliseconds: 800))
                                  .scale(),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: _buildActionCard(
                                context,
                                title: 'Library',
                                imagePath: 'assets/4.png',
                                color: AppColors.neutral10,
                                onTap: () {},
                              )
                                  .animate(controller: _animationController)
                                  .fadeIn(delay: const Duration(milliseconds: 900))
                                  .scale(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Recent Creations Section (Unchanged)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recent Creations',
                          style: AppTextStyles.heading5Bold.copyWith(
                            color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
                          ),
                        )
                            .animate(controller: _animationController)
                            .fadeIn(delay: const Duration(milliseconds: 1000))
                            .slideX(begin: -0.2, end: 0),
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 200,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              _buildVideoCard('Two Guys Playing Football', '2 days ago')
                                  .animate(controller: _animationController)
                                  .fadeIn(delay: const Duration(milliseconds: 1100))
                                  .slideX(begin: 0.2, end: 0),
                              _buildVideoCard('Friends Hugging', 'Yesterday')
                                  .animate(controller: _animationController)
                                  .fadeIn(delay: const Duration(milliseconds: 1200))
                                  .slideX(begin: 0.2, end: 0),
                              _buildVideoCard('Nature Scene', 'Today')
                                  .animate(controller: _animationController)
                                  .fadeIn(delay: const Duration(milliseconds: 1300))
                                  .slideX(begin: 0.2, end: 0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Upgrade Plan Section (Unchanged)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isDarkMode
                              ? [AppColors.darkNeutral70, AppColors.darkNeutral60]
                              : [AppColors.neutral20, AppColors.neutral30],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Upgrade to Pro',
                              style: AppTextStyles.subtitleBold.copyWith(
                                color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
                              ),
                            )
                                .animate(controller: _animationController)
                                .fadeIn(delay: const Duration(milliseconds: 1400))
                                .slideY(begin: 0.2, end: 0),
                            const SizedBox(height: 10),
                            Text(
                              'Unlock unlimited video generations, HD quality, and priority support!',
                              style: AppTextStyles.bodyRegular.copyWith(
                                color: textColor,
                              ),
                            )
                                .animate(controller: _animationController)
                                .fadeIn(delay: const Duration(milliseconds: 1500)),
                            const SizedBox(height: 15),
                            CustomActionButton(
                              name: 'Upgrade Now',
                              isFormFilled: true, // Set to true to keep the button enabled
                              buttonHeight: 60,
                              isWhiteThemed: false,
                              isOutlined: false,
                              buttonWidth: Window.getHorizontalSize(300),
                              onTap: (startLoading, stopLoading, btnState) async {
                                  startLoading();

                                  // TODO: Handle upgrade logic here
                                  await Future.delayed(const Duration(seconds: 1));

                                  stopLoading();
                                }
                            )
                                .animate(controller: _animationController)
                                .fadeIn(delay: const Duration(milliseconds: 1600))
                                .scale(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard(
      BuildContext context, {
        required String title,
        required String imagePath,
        required Color color,
        required VoidCallback onTap,
        bool isFullWidth = false,
      }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        width: isFullWidth ? double.infinity : null,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.2),
              color.withOpacity(0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 40,
              width: 40,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: AppTextStyles.subtitleSemiBold.copyWith(
                color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoCard(String title, String time) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDarkMode
              ? [AppColors.darkNeutral60, AppColors.darkNeutral50]
              : [AppColors.neutral30, AppColors.neutral40],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDarkMode
                    ? [AppColors.darkNeutral50, AppColors.darkNeutral40]
                    : [AppColors.neutral40, AppColors.neutral50],
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.videocam,
                size: 40,
                color: AppColors.neutral10,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.subtitleMedium.copyWith(
                    color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  time,
                  style: AppTextStyles.captionRegular.copyWith(
                    color: isDarkMode ? AppColors.darkNeutral20 : AppColors.neutral80,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
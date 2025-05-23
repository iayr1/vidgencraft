import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vidgencraft/core/themes/bloc/theme_bloc.dart';
import 'package:vidgencraft/core/constants/app_colors.dart';
import 'package:vidgencraft/core/constants/app_textstyles.dart';
import 'package:vidgencraft/core/utils/windows.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../core/widgets/custom_action_button.dart';

class ProfilePageWrapper extends StatelessWidget {
  const ProfilePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfilePage();
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    Window().adaptDeviceScreenSize(view: WidgetsBinding.instance.platformDispatcher.views.first);
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: Window.getPadding(all: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              // TODO: Implement logout functionality
                              Navigator.pushNamed(context, AppRoutes.login);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(color: Colors.redAccent),
                              ),
                            ),
                            child: const Text('Logout'),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: Icon(
                              isDarkMode ? Icons.light_mode : Icons.dark_mode,
                              color: isDarkMode ? Colors.greenAccent : Colors.black87,
                              size: 24,
                            ),
                            onPressed: () {
                              context.read<ThemeBloc>().add(ToggleThemeEvent());
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: Window.getVerticalSize(12)),
                      Text(
                        'Mayur Chaudhari',
                        style: AppTextStyles.heading4Bold.copyWith(
                          fontSize: Window.getFontSize(28),
                          color: isDarkMode ? AppColors.pureWhite : AppColors.neutral100,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        'mayurchaudhari@gmail.com',
                        style: AppTextStyles.bodyRegular.copyWith(
                          fontSize: Window.getFontSize(16),
                          color: isDarkMode ? AppColors.darkNeutral30 : AppColors.neutral50,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: isDarkMode ? AppColors.neutral70 : Colors.white,
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    isScrollable: true,
                    controller: _tabController,
                    indicatorColor: Colors.black,
                    labelColor: isDarkMode ? Colors.white : Colors.black,
                    unselectedLabelColor: isDarkMode ? Colors.grey : Colors.black54,
                    tabs: const [
                      Tab(text: 'Profile'),
                      Tab(text: 'Billing'),
                      Tab(text: 'Upgrade'),
                      Tab(text: 'Notifications'),
                      Tab(text: 'Refer & Earn'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      ProfileTab(),
                      BillingTab(),
                      UpgradeTab(),
                      NotificationsTab(),
                      ReferEarnTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: Window.getPadding(all: 20),
      child: ListView(
        children: [
          Text(
            'Personal Details',
            style: AppTextStyles.heading5Bold.copyWith(
              fontSize: Window.getFontSize(22),
              color: isDarkMode ? AppColors.pureWhite : AppColors.neutral100,
            ),
          ),
          SizedBox(height: Window.getVerticalSize(20)),
          _buildTextField(context, 'Full Name', 'Mayur Chaudhari'),
          _buildTextField(context, 'Email', 'mayurchaudhari@gmail.com'),
          _buildTextField(context, 'Phone', '+91 934 567 8900'),
          _buildTextField(context, 'Address', '123 Main St, Mumbai, India'),
          SizedBox(height: Window.getVerticalSize(20)),
          CustomActionButton(
            name: 'Save Changes',
            isFormFilled: true,
            onTap: (startLoading, stopLoading, btnState) {
              // TODO: Implement save changes functionality
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String label, String initialValue) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: Window.getPadding(bottom: 15),
      child: TextFormField(
        initialValue: initialValue,
        style: AppTextStyles.bodyRegular.copyWith(
          fontSize: Window.getFontSize(14),
          color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: AppTextStyles.captionRegular.copyWith(
            fontSize: Window.getFontSize(12),
            color: isDarkMode ? AppColors.darkNeutral30 : AppColors.neutral50,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
          ),
          filled: true,
          fillColor: isDarkMode ? AppColors.darkNeutral80 : AppColors.neutral10,
          contentPadding: Window.getSymmetricPadding(horizontal: 15, vertical: 12),
        ),
      ),
    );
  }
}

class BillingTab extends StatelessWidget {
  const BillingTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: Window.getPadding(all: 20),
      child: ListView(
        children: [
          Text(
            'Billing Information',
            style: AppTextStyles.heading5Bold.copyWith(
              fontSize: Window.getFontSize(22),
              color: isDarkMode ? AppColors.pureWhite : AppColors.neutral100,
            ),
          ),
          SizedBox(height: Window.getVerticalSize(20)),
          _buildBillingCard(context, 'Visa **** 1234', 'Expires: 12/25'),
          _buildBillingCard(context, 'Mastercard **** 5678', 'Expires: 06/24'),
          SizedBox(height: Window.getVerticalSize(20)),
          CustomActionButton(
            name: 'Add Payment Method',
            isFormFilled: true,
            onTap: (startLoading, stopLoading, btnState) {
              // TODO: Implement add payment method functionality
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBillingCard(BuildContext context, String cardNumber, String expiry) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      margin: Window.getMargin(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
      ),
      color: isDarkMode ? AppColors.darkNeutral80 : AppColors.pureWhite,
      elevation: 3,
      child: ListTile(
        leading: Icon(
          Icons.credit_card,
          color: isDarkMode ? AppColors.darkPrimary : AppColors.primary,
          size: Window.getSize(24),
        ),
        title: Text(
          cardNumber,
          style: AppTextStyles.bodyRegular.copyWith(
            fontSize: Window.getFontSize(14),
            color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
          ),
        ),
        subtitle: Text(
          expiry,
          style: AppTextStyles.captionRegular.copyWith(
            fontSize: Window.getFontSize(12),
            color: isDarkMode ? AppColors.darkNeutral30 : AppColors.neutral50,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: Window.getSize(16),
          color: isDarkMode ? AppColors.darkNeutral30 : AppColors.neutral50,
        ),
      ),
    );
  }
}

class UpgradeTab extends StatelessWidget {
  const UpgradeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: Window.getPadding(all: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upgrade Your Plan',
            style: AppTextStyles.heading5Bold.copyWith(
              fontSize: Window.getFontSize(22),
              color: isDarkMode ? AppColors.pureWhite : AppColors.neutral100,
            ),
          ),
          SizedBox(height: Window.getVerticalSize(20)),
          _buildPlanCard(
            context,
            isDarkMode,
            title: 'Free',
            price: '\$0/month',
            features: [
              'Basic video generation',
              'Limited exports',
              'Community support',
            ],
            buttonLabel: 'Current Plan',
            isDisabled: true,
          ),
          SizedBox(height: Window.getVerticalSize(16)),
          _buildPlanCard(
            context,
            isDarkMode,
            title: 'Pro',
            price: '\$9.99/month',
            features: [
              'Unlimited video generation',
              'HD export quality',
              'Priority support',
            ],
            buttonLabel: 'Upgrade to Pro',
            isDisabled: false,
          ),
          SizedBox(height: Window.getVerticalSize(16)),
          _buildPlanCard(
            context,
            isDarkMode,
            title: 'Premium',
            price: '\$19.99/month',
            features: [
              'Everything in Pro',
              'Team collaboration tools',
              'Advanced analytics',
            ],
            buttonLabel: 'Upgrade to Premium',
            isDisabled: false,
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(
      BuildContext context,
      bool isDarkMode, {
        required String title,
        required String price,
        required List<String> features,
        required String buttonLabel,
        required bool isDisabled,
      }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
      ),
      color: isDarkMode ? AppColors.darkNeutral80 : AppColors.pureWhite,
      elevation: 3,
      child: Padding(
        padding: Window.getPadding(all: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.titleBold.copyWith(
                fontSize: Window.getFontSize(20),
                color: isDarkMode ? AppColors.neutral10 : AppColors.neutral100,
              ),
            ),
            SizedBox(height: Window.getVerticalSize(6)),
            Text(
              price,
              style: AppTextStyles.bodySemiBold.copyWith(
                fontSize: Window.getFontSize(16),
                color: isDarkMode ? AppColors.darkPrimary : AppColors.primary,
              ),
            ),
            SizedBox(height: Window.getVerticalSize(12)),
            ...features.map(
                  (f) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: isDarkMode ? AppColors.darkPrimary : AppColors.primary,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        f,
                        style: AppTextStyles.bodyRegular.copyWith(
                          fontSize: Window.getFontSize(14),
                          color: isDarkMode ? AppColors.darkPrimary : AppColors.neutral100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: Window.getVerticalSize(16)),
            Center(
              child: CustomActionButton(
                name: buttonLabel,
                isFormFilled: !isDisabled,
                buttonWidth: Window.getHorizontalSize(200),
                onTap: (startLoading, stopLoading, btnState) async {
                  if (isDisabled) return;
                  startLoading();
                  await Future.delayed(const Duration(seconds: 1));
                  stopLoading();
                  // TODO: Navigate to payment/upgrade screen
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: Window.getPadding(all: 20),
      child: ListView(
        children: [
          Text(
            'Notifications',
            style: AppTextStyles.heading5Bold.copyWith(
              fontSize: Window.getFontSize(22),
              color: isDarkMode ? AppColors.pureWhite : AppColors.neutral100,
            ),
          ),
          SizedBox(height: Window.getVerticalSize(20)),
          _buildNotificationItem(context, 'New Message', 'You received a new message', '10:30 AM'),
          _buildNotificationItem(context, 'Payment Successful', 'Your payment was processed', 'Yesterday'),
          _buildNotificationItem(context, 'Update Available', 'New app version is ready', '2 days ago'),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(BuildContext context, String title, String subtitle, String time) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      margin: Window.getMargin(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
      ),
      color: isDarkMode ? AppColors.darkNeutral80 : AppColors.pureWhite,
      elevation: 3,
      child: ListTile(
        leading: Icon(
          Icons.notifications,
          color: isDarkMode ? AppColors.darkPrimary : AppColors.primary,
          size: Window.getSize(24),
        ),
        title: Text(
          title,
          style: AppTextStyles.bodyRegular.copyWith(
            fontSize: Window.getFontSize(14),
            color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: AppTextStyles.captionRegular.copyWith(
            fontSize: Window.getFontSize(12),
            color: isDarkMode ? AppColors.darkNeutral30 : AppColors.neutral50,
          ),
        ),
        trailing: Text(
          time,
          style: AppTextStyles.captionRegular.copyWith(
            fontSize: Window.getFontSize(12),
            color: isDarkMode ? AppColors.darkNeutral30 : AppColors.neutral50,
          ),
        ),
      ),
    );
  }
}

class ReferEarnTab extends StatelessWidget {
  const ReferEarnTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: Window.getPadding(all: 20),
      child: ListView(
        children: [
          Text(
            'Refer & Earn',
            style: AppTextStyles.heading5Bold.copyWith(
              fontSize: Window.getFontSize(22),
              color: isDarkMode ? AppColors.pureWhite : AppColors.neutral100,
            ),
          ),
          SizedBox(height: Window.getVerticalSize(20)),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
            ),
            color: isDarkMode ? AppColors.darkNeutral80 : AppColors.pureWhite,
            elevation: 3,
            child: Padding(
              padding: Window.getPadding(all: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Invite Friends, Earn Rewards!',
                    style: AppTextStyles.titleSemiBold.copyWith(
                      fontSize: Window.getFontSize(18),
                      color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
                    ),
                  ),
                  SizedBox(height: Window.getVerticalSize(10)),
                  Text(
                    'Share your unique referral code with friends and earn rewards when they sign up and upgrade to Pro.',
                    style: AppTextStyles.bodyRegular.copyWith(
                      fontSize: Window.getFontSize(16),
                      color: isDarkMode ? AppColors.darkNeutral30 : AppColors.neutral50,
                    ),
                  ),
                  SizedBox(height: Window.getVerticalSize(20)),
                  Container(
                    padding: Window.getSymmetricPadding(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isDarkMode ? AppColors.darkNeutral50 : AppColors.neutral30,
                      ),
                      borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'REF123456',
                          style: AppTextStyles.bodyBold.copyWith(
                            fontSize: Window.getFontSize(16),
                            color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.copy,
                            color: isDarkMode ? AppColors.darkNeutral30 : AppColors.neutral50,
                            size: Window.getSize(20),
                          ),
                          onPressed: () {
                            // TODO: Implement copy to clipboard functionality
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Window.getVerticalSize(20)),
                  Center(
                    child: CustomActionButton(
                      name: 'Share Referral Code',
                      isFormFilled: true,
                      buttonWidth: Window.getHorizontalSize(200),
                      onTap: (startLoading, stopLoading, btnState) {
                        // TODO: Implement share functionality
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Window.getVerticalSize(20)),
          Text(
            'Your Rewards',
            style: AppTextStyles.titleSemiBold.copyWith(
              fontSize: Window.getFontSize(18),
              color: isDarkMode ? AppColors.pureWhite : AppColors.neutral100,
            ),
          ),
          SizedBox(height: Window.getVerticalSize(10)),
          _buildRewardItem(context, '2 Friends Referred', 'Earned: \$10 Credit'),
          _buildRewardItem(context, '1 Pro Upgrade', 'Earned: \$20 Credit'),
        ],
      ),
    );
  }

  Widget _buildRewardItem(BuildContext context, String title, String reward) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      margin: Window.getMargin(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Window.getRadiusSize(12)),
      ),
      color: isDarkMode ? AppColors.darkNeutral80 : AppColors.pureWhite,
      elevation: 3,
      child: ListTile(
        leading: Icon(
          Icons.card_giftcard,
          color: isDarkMode ? AppColors.darkPrimary : AppColors.primary,
          size: Window.getSize(24),
        ),
        title: Text(
          title,
          style: AppTextStyles.bodyRegular.copyWith(
            fontSize: Window.getFontSize(14),
            color: isDarkMode ? AppColors.darkNeutral10 : AppColors.neutral100,
          ),
        ),
        subtitle: Text(
          reward,
          style: AppTextStyles.captionRegular.copyWith(
            fontSize: Window.getFontSize(12),
            color: isDarkMode ? AppColors.darkNeutral30 : AppColors.neutral50,
          ),
        ),
      ),
    );
  }
}
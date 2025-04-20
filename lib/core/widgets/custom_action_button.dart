import 'package:argon_buttons_flutter_fix/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/app_colors.dart';
import '../constants/app_textstyles.dart';
import '../utils/windows.dart';

class CustomActionButton extends StatelessWidget {
  final Function(
      Function startLoading,
      Function stopLoading,
      ButtonState btnState,
      ) onTap;
  final String name;
  final bool showAction;
  final bool isFormFilled;
  final bool isOutlined;
  final Widget? leading;
  final bool isWhiteThemed;
  final bool shouldAnimate;
  final bool? isLoaded;
  final bool isError;
  final double? buttonWidth;
  final double? buttonHeight;

  const CustomActionButton({
    super.key,
    required this.onTap,
    required this.name,
    required this.isFormFilled,
    this.isError = false,
    this.showAction = true,
    this.isOutlined = false,
    this.leading,
    this.isWhiteThemed = false,
    this.shouldAnimate = true,
    this.isLoaded,
    this.buttonWidth,
    this.buttonHeight,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Define color palette for better aesthetics
    final Color primaryColor = isDarkMode ? AppColors.darkPrimary70 : AppColors.primary70;
    final Color disabledColor = isDarkMode ? AppColors.neutral50 : AppColors.neutral30;
    final Color accentColor = isDarkMode ? AppColors.darkPrimary100 : AppColors.primary100;

    // Button background color or gradient
    final buttonDecoration = isFormFilled && !isOutlined
        ? BoxDecoration(
      gradient: LinearGradient(
        colors: [
          AppColors.primary90,
          Color.lerp(AppColors.primary90, accentColor, 0.2)!,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(Window.getRadiusSize(15)),
      boxShadow: [
        BoxShadow(
          color: isDarkMode ? Colors.black26 : Colors.grey.withOpacity(0.2),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    )
        : BoxDecoration(
      gradient: isOutlined
          ? null
          : LinearGradient(
        colors: [
          disabledColor,
          Color.lerp(disabledColor, isDarkMode ? Colors.black54 : Colors.white, 0.1)!,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(
        color: isFormFilled
            ? accentColor
            : (isDarkMode ? AppColors.neutral10.withOpacity(0.5) : AppColors.neutral100.withOpacity(0.3)),
        width: isOutlined ? 1.4 : 0.8,
      ),
      borderRadius: BorderRadius.circular(Window.getRadiusSize(15)),
      boxShadow: [
        BoxShadow(
          color: isDarkMode ? Colors.black12 : Colors.grey.withOpacity(0.1),
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ],
    );

    // Text and icon color
    final Color textColor = isFormFilled
        ? (isOutlined
        ? accentColor
        : (isDarkMode ? AppColors.neutral10 : AppColors.neutral10))
        : (isDarkMode ? AppColors.neutral10.withOpacity(0.7) : AppColors.neutral50);

    // Loader color
    final Color loaderColor = isWhiteThemed || isOutlined
        ? accentColor
        : (isFormFilled ? AppColors.neutral100 : textColor);

    // Calculate button height, ensuring a minimum to avoid text clipping
    final double effectiveHeight = buttonHeight ?? Window.getVerticalSize(50); // Reduced from 50 to 42

    return Container(
      decoration: buttonDecoration,
      child: ArgonButton(
        height: effectiveHeight,
        width: buttonWidth ??
            Window.getHorizontalSize(MediaQuery.of(context).size.width),
        loader: Transform.scale(
          scale: shouldAnimate ? 0.7 : 0.9, // Adjusted scale for smaller loader
          child: Container(
            height: Window.getVerticalSize(32), // Reduced loader size
            width: Window.getHorizontalSize(32),
            padding: const EdgeInsets.all(1),
            child: SpinKitDoubleBounce(color: loaderColor),
          ),
        ),
        onTap: onTap,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leading != null)
                ColorFiltered(
                  colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
                  child: leading,
                ),
              if (leading != null)
                SizedBox(width: Window.getHorizontalSize(8)), // Slightly reduced spacing
              Text(
                name,
                style: AppTextStyles.subtitleSemiBold.copyWith(
                  color: textColor,
                  fontSize: Window.getFontSize(14), // Reduced font size to fit
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis, // Prevent text overflow
              ),
            ],
          ),
        ),
      ),
    );
  }
}
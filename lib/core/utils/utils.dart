import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vidgencraft/core/utils/windows.dart';
import '../constants/app_colors.dart';

class Utils {
  static Future<void> debugLog(String string) async {
    if (kDebugMode) {
      log("DEBUG: $string");
    }
  }

  static Future<void> showCustomDialog(BuildContext context,
      String title,
      String? body, {
        void Function()? onOkay,
      }) async {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return ClipRRect(
          child: Container(
            width: Window.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Window.getHorizontalSize(40)),
                  topRight: Radius.circular(Window.getHorizontalSize(40))),
            ),
            child: Padding(
              padding: Window.getPadding(left: 20, right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Window.getVerticalSize(30)),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: Window.getFontSize(20),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: Window.getVerticalSize(20)),
                  Text(
                    body!,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: Window.getVerticalSize(20)),
                  GestureDetector(
                    onTap: onOkay ??
                            () {
                          Navigator.pop(context);
                        },
                    child: Container(
                      width: Window.width,
                      height: Window.getVerticalSize(50),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text("Close",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: Window.getVerticalSize(15)),
                ],
              ),
            ),
          ),
        );
      },
    );
    HapticFeedback.vibrate();
  }

  // showCustomDatePicker
  static Future<DateTime?> showCustomDatePicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.neutral30,
              onPrimary: Colors.black,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
            ),
            indicatorColor: AppColors.neutral30,
          ),
          child: child!,
        );
      },
    );
  }

  // showCustomTimePicker
  static Future<TimeOfDay?> showCustomTimePicker({
    required BuildContext context,
    TimeOfDay? initialTime,
  }) async {
    final TimeOfDay now = TimeOfDay.now();

    return await showTimePicker(
      context: context,
      initialTime: initialTime ?? now,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.neutral30,
              onPrimary: Colors.black,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }


  // Format date to 'EEEE, dd MMM' (e.g., "Monday, 05 Feb")
  static String formatToDayMonth(String? date) {
    if (date == null) return '';
    return DateFormat('EEEE, dd MMM').format(DateTime.parse(date));
  }

  // Format date to 'yyyy-MM-dd' (for API requests or filtering)
  static String formatToYYYYMMDD(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  // Format date to 'dd/MM/yyyy' (for display purposes)
  static String formatToDDMMYYYY(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  // Format date to 'dd/MMM/yyyy'
  static String formatToDDMMMYYYY(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  static String formatTimeWithAMPM(String timeIn24HrFormat) {
    try {
      // Parse the 24-hour format string into a DateTime object
      final DateTime time = DateFormat("HH:mm:ss").parse(timeIn24HrFormat);
      // Format it into 12-hour format with AM/PM
      return DateFormat("hh:mm a").format(time);
    } catch (e) {
      // Return the original time in case of any error (e.g., invalid format)
      return timeIn24HrFormat;
    }
  }

}

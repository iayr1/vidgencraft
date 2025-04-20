import 'package:flutter/material.dart';

class AppColors {
  // Light Mode Colors
  static const Color primary100 = Color(0xFF035388);
  static const Color primary90 = Color(0xFF0A6A9D);
  static const Color primary80 = Color(0xFF1F87B2);
  static const Color primary70 = Color(0xFF35A4C7);
  static const Color primary60 = Color(0xFF4BC1DC);
  static const Color primary50 = Color(0xFF61DEF1);
  static const Color primary40 = Color(0xFF9AE7F6);
  static const Color primary30 = Color(0xFFC4F0FB);
  static const Color primary20 = Color(0xFFE3F8FE);
  static const Color primary10 = Color(0xFFF2FCFF);

  static const Color secondaryPurple100 = Color(0xFF78297F);
  static const Color secondaryPurple90 = Color(0xFF91409F);
  static const Color secondaryPurple80 = Color(0xFFA957BF);
  static const Color secondaryPurple70 = Color(0xFFC06FDF);
  static const Color secondaryPurple60 = Color(0xFFD886FF);
  static const Color secondaryPurple50 = Color(0xFFE8A9FF);
  static const Color secondaryPurple40 = Color(0xFFF4CCFF);
  static const Color secondaryPurple20 = Color(0xFFFDF3FF);
  static const Color secondaryPurple10 = Color(0xFFFDF7FF);

  static const Color secondaryGreen100 = Color(0xFF038B6B);
  static const Color secondaryGreen90 =  Color(0xFF0DA681);
  static const Color secondaryGreen80 = Color(0xFF1FC197);
  static const Color secondaryGreen70 = Color(0xFF32DCAD);
  static const Color secondaryGreen60 = Color(0xFF45F1C3);
  static const Color secondaryGreen50 = Color(0xFF77F7D3);
  static const Color secondaryGreen40 = Color(0xAAA9F9E4);
  static const Color secondaryGreen30 = Color(0xCCDDFAF1);
  static const Color secondaryGreen20 = Color(0xEEEFFBF8);
  static const Color secondaryGreen10 = Color(0xFFF7FEFD);

  static const Color neutral100 = Color(0xFF000000);
  static const Color neutral90 = Color(0xFF1A1A1A);
  static const Color neutral80 = Color(0xFF333333);
  static const Color neutral70 = Color(0xFF4D4D4D);
  static const Color neutral60 = Color(0xFF666666);
  static const Color neutral50 = Color(0xFF808080);
  static const Color neutral40 = Color(0xFF999999);
  static const Color neutral30 = Color(0xFFB3B3B3);
  static const Color neutral20 = Color(0xCCCCCC);
  static const Color neutral10 = Color(0xFFE6E6E6);

  static const Color error100 = Color(0xFF9F2D36);
  static const Color error90 = Color(0xFFBB4150);
  static const Color error80 = Color(0xFFD7556A);
  static const Color error70 = Color(0xFFF26984);
  static const Color error60 = Color(0xFFEF7D9E);
  static const Color error50 = Color(0xFFF090B8);
  static const Color error40 = Color(0xFFF4A4D2);
  static const Color error30 = Color(0xFFF7B8EC);
  static const Color error20 = Color(0xFFFADEF6);
  static const Color error10 = Color(0xFFFDF0FA);

  // Dark Mode Colors (adjusted based on lightest shades with reduced brightness)
  static const Color darkPrimary100 = Color(0xFF035388); // Base dark color
  static const Color darkPrimary90 = Color(0xFF0A6A9D);
  static const Color darkPrimary80 = Color(0xFF1F87B2);
  static const Color darkPrimary70 = Color(0xFF35A4C7);
  static const Color darkPrimary60 = Color(0xFF4BC1DC);
  static const Color darkPrimary50 = Color(0xFF61DEF1);
  static const Color darkPrimary40 = Color(0xFF9AE7F6);
  static const Color darkPrimary30 = Color(0xFFC4F0FB);
  static const Color darkPrimary20 = Color(0xFFE3F8FE);
  static  Color darkPrimary10 = Color(0xFFF2FCFF).withOpacity(0.9); // Slightly muted

  static const Color darkSecondaryPurple100 = Color(0xFF78297F);
  static const Color darkSecondaryPurple90 = Color(0xFF91409F);
  static const Color darkSecondaryPurple80 = Color(0xFFA957BF);
  static const Color darkSecondaryPurple70 = Color(0xFFC06FDF);
  static const Color darkSecondaryPurple60 = Color(0xFFD886FF);
  static const Color darkSecondaryPurple50 = Color(0xFFE8A9FF);
  static const Color darkSecondaryPurple40 = Color(0xFFF4CCFF);
  static const Color darkSecondaryPurple30 = Color(0xFFFBEFFF);
  static const Color darkSecondaryPurple20 = Color(0xFFFDF3FF);
  static  Color darkSecondaryPurple10 = Color(0xFFFDF7FF).withOpacity(0.9);

  static const Color darkSecondaryGreen100 = Color(0xFF038B6B);
  static const Color darkSecondaryGreen90 = Color(0xFF0DA681);
  static const Color darkSecondaryGreen80 = Color(0xFF1FC197);
  static const Color darkSecondaryGreen70 = Color(0xFF32DCAD);
  static const Color darkSecondaryGreen60 = Color(0xFF45F1C3);
  static const Color darkSecondaryGreen50 = Color(0xFF77F7D3);
  static const Color darkSecondaryGreen40 = Color(0xAAA9F9E4);
  static const Color darkSecondaryGreen30 = Color(0xCCDDFAF1);
  static const Color darkSecondaryGreen20 = Color(0xEEEFFBF8);
  static  Color darkSecondaryGreen10 = Color(0xFFF7FEFD).withOpacity(0.9);

  static const Color darkNeutral100 = Color(0xFF000000);
  static const Color darkNeutral90 = Color(0xFF1A1A1A);
  static const Color darkNeutral80 = Color(0xFF333333);
  static const Color darkNeutral70 = Color(0xFF4D4D4D);
  static const Color darkNeutral60 = Color(0xFF666666);
  static const Color darkNeutral50 = Color(0xFF808080);
  static const Color darkNeutral40 = Color(0xFF999999);
  static const Color darkNeutral30 = Color(0xFFB3B3B3);
  static const Color darkNeutral20 = Color(0xCCCCCC);
  static  Color darkNeutral10 = Color(0xFFE6E6E6).withOpacity(0.3); // Lighter for contrast

  static const Color darkError100 = Color(0xFF9F2D36);
  static const Color darkError90 = Color(0xFFBB4150);
  static const Color darkError80 = Color(0xFFD7556A);
  static const Color darkError70 = Color(0xFFF26984);
  static const Color darkError60 = Color(0xFFEF7D9E);
  static const Color darkError50 = Color(0xFFF090B8);
  static const Color darkError40 = Color(0xFFF4A4D2);
  static const Color darkError30 = Color(0xFFF7B8EC);
  static const Color darkError20 = Color(0xFFFADEF6);
  static  Color darkError10 = Color(0xFFFDF0FA).withOpacity(0.9);

  // Convenience getters for default shades
  static Color get primary => primary90;
  static Color get secondaryPurple => secondaryPurple50;
  static Color get secondaryGreen => secondaryGreen50;
  static Color get neutral => neutral50;
  static Color get error => error50;

  static Color get darkPrimary => darkPrimary50;
  static Color get darkSecondaryPurple => darkSecondaryPurple50;
  static Color get darkSecondaryGreen => darkSecondaryGreen50;
  static Color get darkNeutral => darkNeutral50;
  static Color get darkError => darkError50;



  static const lightHeavenStart = Color(0xFFFCE4EC);
  static const lightHeavenEnd = Color(0xFFE1BEE7);
  static const darkHeavenStart = Color(0xFF1A237E);
  static const darkHeavenEnd = Color(0xFF311B92);
  static const accentGlow = Color(0xFF00E5FF);
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors {
  AppColors._();
  static const Color lightModeMainColor = Colors.white;
  static const Color darkModeMainColor = Colors.black;
  static const Color lightModeTextcolor = Color.fromARGB(255, 41, 40, 40);
  static const Color darkModeTextColor = Colors.white;
  static const Color primaryColor = Color(0xFF5d69b3);
  static const Color textColor1 = Colors.grey;
  static Color mainColor =
      (Get.isDarkMode) ? darkModeMainColor : lightModeMainColor;
  static Color textColor =
      (Get.isDarkMode) ? darkModeTextColor : lightModeTextcolor;
  static Color btn_color = Color.fromARGB(255, 118, 131, 212);
  static const Color mailColor = const Color.fromARGB(255, 194, 211, 247);
  static const Color femailColor = const Color.fromARGB(255, 240, 211, 238);

  static Gradient colorOfButtonDuration = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.primaryColor.withOpacity(0.6),
      Colors.white,
    ],
  );
}

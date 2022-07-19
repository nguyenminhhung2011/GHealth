import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors {
  AppColors._();
  static const Color lightModeMainColor = Colors.white;
  static const Color darkModeMainColor = Colors.black;
  static const Color lightModeTextcolor = Color.fromARGB(255, 41, 40, 40);
  static const Color darkModeTextColor = Colors.white;
  static const Color primaryColor = Color(0xFF5d69b3);
  static Color mainColor =
      (Get.isDarkMode) ? darkModeMainColor : lightModeMainColor;
  static Color textColor =
      (Get.isDarkMode) ? darkModeTextColor : lightModeTextcolor;
}

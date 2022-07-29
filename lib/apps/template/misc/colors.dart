import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors {
  AppColors._();

  static const Color lightModeMainColor = Colors.white;
  static const Color darkModeMainColor = Colors.black;
  static const Color lightModeTextcolor = Color.fromARGB(255, 41, 40, 40);
  static const Color darkModeTextColor = Colors.white;
  static const Color primaryColor = Color(0xFF5d69b3);
  static const Color primaryColor1 = Color.fromARGB(157, 118, 201, 239);
  static const Color primaryColor2 = Color.fromARGB(157, 164, 118, 239);
  static const Color textColor1 = Colors.grey;
  static Color mainColor =
      (Get.isDarkMode) ? darkModeMainColor : lightModeMainColor;
  static Color textColor =
      (Get.isDarkMode) ? darkModeTextColor : lightModeTextcolor;
  static const Color btn_color = Color.fromARGB(255, 118, 131, 212);
  static const Color mailColor = Color.fromARGB(255, 194, 211, 247);
  static const Color backGroundTableColor =
      const Color.fromARGB(255, 232, 243, 252);
  static const Color femailColor = Color.fromARGB(255, 240, 211, 238);
  static const Color approxWhite = Color.fromARGB(
      255, 245, 245, 251); //Use for background of button and container

  static Gradient colorOfButtonDuration = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.primaryColor.withOpacity(0.6),
      Colors.white,
    ],
  );
  static Gradient colorContainerTodayTarget = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      primaryColor1.withOpacity(0.2),
      primaryColor2.withOpacity(0.2),
    ],
  );
  static Gradient colorGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      primaryColor1.withOpacity(0.8),
      primaryColor2.withOpacity(0.8),
    ],
  );
  static Gradient colorGradient1 = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      primaryColor1.withOpacity(1),
      primaryColor2.withOpacity(0.5),
    ],
  );
  static Gradient colorGradient2 = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      primaryColor1.withOpacity(0.2),
      primaryColor2.withOpacity(0.05),
    ],
  );
  static Gradient colorOfBarChar = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      primaryColor1.withOpacity(0.3),
      primaryColor1.withOpacity(0.3),
      primaryColor2.withOpacity(0.3),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/basic_controller/fill_profile_controller.dart';
import 'package:gold_health/apps/controls/basic_controller/select_duration_controller.dart';
import 'package:gold_health/apps/controls/basic_controller/select_gender_controller.dart';
import 'package:gold_health/apps/pages/basic_info_screen/fill_profile.dart';
import 'package:gold_health/apps/pages/basic_info_screen/get_height_screen.dart';
import 'package:gold_health/apps/pages/basic_info_screen/get_old_screen.dart';
import 'package:gold_health/apps/pages/basic_info_screen/get_weight_screen.dart';
import 'package:gold_health/apps/pages/basic_info_screen/select_duration_screen.dart';
import 'package:gold_health/apps/pages/basic_info_screen/select_gender_screen.dart';

import 'get_height_controller.dart';
import 'get_old_controller.dart';
import 'get_weight_controller.dart';
import '../sign_up_controller.dart';

class BasicInfoC extends GetxController {
  final signUpC = Get.find<SignUpC>();

  late RxDouble animaInfo = 0.0.obs;
  late RxDouble aimaGoal = 0.0.obs;

  late RxInt currentIndex = 0.obs;
  PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  void pageChange(int index) {
    pageController.animateToPage(index,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
//  pageController.jumpToPage(index);
  }

  void changeTab(int newTab) {
    int currentTab = currentIndex.value;
    (newTab < 6)
        ? animaInfo.value = (newTab + 1) / 6 * 60
        : aimaGoal.value = (newTab - 5) / 6 * 60;
    if (currentTab == newTab) return;
    switch (currentTab) {
      case 0:
        Get.delete<FillProfileC>();
        break;
      case 1:
        Get.delete<SelectGenderC>();
        break;
      case 2:
        Get.delete<GetOldC>();
        break;
      case 3:
        Get.delete<GetHeightC>();
        break;
      case 4:
        Get.delete<GetWeightC>();
        break;
      case 5:
        Get.delete<SelectDurationC>();
        break;
      default:
        break;
    }
    currentIndex.value = newTab;
    update();
  }

  Widget getCurrentTab() {
    int index = currentIndex.value;
    switch (index) {
      case 0:
        return const FillProfileScreen();
      case 1:
        return SelectGenderScreen();
      case 2:
        return const GetOldScreen();
      case 3:
        return GetHeightScreen();
      case 4:
        return GetWeightScreen();
      case 5:
        return SelectDurationScreen();
      default:
        return const FillProfileScreen();
    }
  }

  onPageChangeUpdate(int value) {
    // switch (currentIndex.value) {
    //   case 0:
    //     Get.delete<FillProfileC>();
    //     break;
    //   case 1:
    // }
    currentIndex.value = value;
    if (value >= 0 && value <= 5) {
      animaInfo.value = ((value + 1) / 6) * 60;
    }
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

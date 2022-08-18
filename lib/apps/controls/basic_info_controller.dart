import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/fill_profile_controller.dart';
import 'package:gold_health/apps/controls/select_duration_controller.dart';
import 'package:gold_health/apps/controls/select_gender_controller.dart';
import 'package:gold_health/apps/pages/basic_info_screen/fill_profile.dart';
import 'package:gold_health/apps/pages/basic_info_screen/get_height_screen.dart';
import 'package:gold_health/apps/pages/basic_info_screen/get_old_screen.dart';
import 'package:gold_health/apps/pages/basic_info_screen/get_weight_screen.dart';
import 'package:gold_health/apps/pages/basic_info_screen/select_duration_screen.dart';
import 'package:gold_health/apps/pages/basic_info_screen/select_gender_screen.dart';

import 'get_height_controller.dart';
import 'get_old_controller.dart';
import 'get_weight_controller.dart';
import 'sign_up_controller.dart';

class BasicInfoC extends GetxController {
  // final fillProfileC = Get.find<FillProfileC>();
  // final getHeightC = Get.find<GetHeightC>();
  // final getWeightC = Get.find<GetWeightC>();
  // final selectDurationC = Get.find<SelectDurationC>();
  // final selectGenderC = Get.find<SelectGenderC>();
  // final getOldC = Get.find<GetOldC>();

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

  onPageChangeUpdate(int value) {
    currentIndex.value = value;
    if (value >= 0 && value <= 5) {
      animaInfo.value = ((value + 1) / 6) * 60;
    }
    update();
  }

  RxList<Widget> listPages = [
    const FillProfileScreen(),
    SelectGenderScreen(),
    const GetOldScreen(),
    GetWeightScreen(),
    GetHeightScreen(),
    SelectDurationScreen(),
  ].obs;
  @override
  void onClose() {
    Get.delete<FillProfileC>();
    Get.delete<GetHeightC>();
    Get.delete<GetWeightC>();
    Get.delete<SelectDurationC>();
    Get.delete<SelectGenderC>();
    Get.delete<GetOldC>();
    super.onClose();
  }
}

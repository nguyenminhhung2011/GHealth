import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/mealPlanner/mealPlannerScreen.dart';
import '../../pages/workout_tracker_screen/workout_tracker_screen.dart';
import '../meal_plan_controller.dart';
import '../workout_plan_controller.dart';

class DailyPlanController extends GetxController {
  static const int nutrition = 0;
  static const int workout = 1;
  static const int water = 2;
  static const int step = 3;
  static const int fasting = 4;

  Rx<int> currentTab = nutrition.obs;

  TextEditingController text = TextEditingController();

  void changeTab(int newTabIndex) {
    int currentIndex = currentTab.value;
    if (currentIndex == newTabIndex) return;
    switch (currentIndex) {
      case 0:
        Get.delete<MealPlanController>();
        break;
      case 1:
        Get.delete<WorkoutPlanController>();
        break;
      default:
        break;
    }
    currentTab.value = newTabIndex;
  }

  Widget getCurrentTab() {
    int index = currentTab.value;
    switch (index) {
      case 0:
        return MealPlannerScreen();
      case 1:
        return WorkoutTrackerScreen();
      default:
        return MealPlannerScreen();
    }
  }
}

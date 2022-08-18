import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/daily_sleep_controller.dart';
import 'package:gold_health/apps/controls/dailyPlanController/daily_step_controller.dart';
import 'package:gold_health/apps/controls/dailyPlanController/daily_waterController.dart';
import 'package:gold_health/apps/controls/dailyPlanController/fasting_plan_controller.dart';
import 'package:gold_health/apps/pages/list_plan_screen/daily_water_screen.dart';
import 'package:gold_health/apps/pages/list_plan_screen/fasting_plan/fasting_plan_screen.dart';
import 'package:gold_health/apps/pages/sleep_tracker/sleep_tracker_screen.dart';

import '../../pages/list_plan_screen/daily_step_screen.dart.dart';
import '../../pages/mealPlanner/meal_planner_screen.dart';
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
      case 2:
        Get.delete<DailyStepController>();
        break;
      case 3:
        Get.delete<DailyWaterController>();
        break;
      case 4:
        Get.delete<FastingPlanController>();
        break;
      case 5:
        Get.delete<DailySleepController>();
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
      case 2:
        return DailyStepScreen();
      case 3:
        return DailyWaterScreen();
      case 4:
        return const FastingPlanScreen();
      case 5:
        return const SleepTrackerScreen();
      default:
        return MealPlannerScreen();
    }
  }
}

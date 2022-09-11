import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/daily_plan_controller.dart';

import '../controls/activity_tracker_controller.dart';
import '../controls/home_screen_controller.dart';
import '../controls/dashboard_controller.dart';

class DashBoardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashBoardControl>(() => DashBoardControl());
    Get.lazyPut<HomeScreenControl>(() => HomeScreenControl());
    Get.lazyPut<DailyPlanController>(() => DailyPlanController());
    Get.lazyPut<ActivityTrackerC>(() => ActivityTrackerC());
  }
}

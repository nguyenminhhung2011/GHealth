import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/daily_plan_controller.dart';
import 'package:gold_health/apps/controls/dailyPlanController/daily_nutrition_controller.dart';

import '../controls/home_screen_controller.dart';
import '../controls/dashboard_controller.dart';

class DashBoardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeScreenControl>(() => HomeScreenControl());
    Get.lazyPut<DashBoardControl>(() => DashBoardControl());
    Get.lazyPut(() => DailyPlanController());
  }
}

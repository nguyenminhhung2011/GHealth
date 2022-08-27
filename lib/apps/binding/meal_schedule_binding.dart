import 'package:get/get.dart';

import '../controls/dailyPlanController/meal_plan/meal_schedule_controller.dart';

class MealScheduleB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MealScheduleC>(() => MealScheduleC());
  }
}

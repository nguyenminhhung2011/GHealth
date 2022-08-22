import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/meal_plan/meal_detail_controller.dart';

class MealDetailB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MealDetailC>(() => MealDetailC());
  }
}

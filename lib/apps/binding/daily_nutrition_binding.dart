import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/meal_plan/daily_nutrition_controller.dart';

class DailyNutritionB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DailyNutritionController());
  }
}

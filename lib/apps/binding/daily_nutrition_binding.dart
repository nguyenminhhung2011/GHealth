import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/daily_nutrition_controller.dart';

class DailyNutritionB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DailyNutritionController());
  }
}

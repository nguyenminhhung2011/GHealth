import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/dailyNutritionController.dart';

class DailyNutritionB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DailyNutritionController());
  }
}

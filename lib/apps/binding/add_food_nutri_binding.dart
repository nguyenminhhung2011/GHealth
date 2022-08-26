import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/meal_plan/add_food_nutri_controller.dart';

class AddFoddNutriB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddFoddNutriC>(() => AddFoddNutriC());
  }
}

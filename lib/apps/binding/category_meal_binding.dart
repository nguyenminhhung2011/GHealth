import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/meal_plan/category_meal_controller.dart';

class CategoryMealB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryMealC>(() => CategoryMealC());
  }
}

import 'package:get/get.dart';

import '../controls/dailyPlanController/meal_plan/view_meal_controller.dart';

class ViewMealB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewMealC>(() => ViewMealC());
  }
}

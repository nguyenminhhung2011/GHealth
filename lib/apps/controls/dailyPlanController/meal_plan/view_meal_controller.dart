import 'package:get/get.dart';

import '../../../data/models/Meal.dart';

class ViewMealC extends GetxController {
  final Rx<List<Meal>> _listMeal = Rx<List<Meal>>([]);
  List<Meal> get listMeal => _listMeal.value;
  @override
  void onInit() {
    super.onInit();
    _listMeal.value = Get.arguments as List<Meal>;
  }
}

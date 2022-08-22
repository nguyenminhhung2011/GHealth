import 'package:get/get.dart';

import '../../../data/models/Meal.dart';

class MealDetailC extends GetxController {
  final Rx<Map<String, dynamic>> _meal = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get meal => _meal.value;
  RxList<Map<String, dynamic>> listSteps = <Map<String, dynamic>>[].obs;
  @override
  void onInit() {
    super.onInit();
    getMeal();
  }

  void getMeal() {
    _meal.value = Get.arguments;
    List<String> stepTemps = [];
    [for (var item in _meal.value['steps']) stepTemps.add(item as String)];
    for (int i = 0; i < stepTemps.length; i++) {
      listSteps.value.add(
        {
          'step': i + 1,
          's': stepTemps[i],
        },
      );
    }
    stepTemps.clear();
    update();
  }
}

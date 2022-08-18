import 'package:get/get.dart';
import 'package:gold_health/apps/controls/get_old_controller.dart';
import 'package:gold_health/apps/controls/get_weight_controller.dart';

import '../controls/fill_profile_controller.dart';

class GetWeightB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetWeightC>(() => GetWeightC());
  }
}

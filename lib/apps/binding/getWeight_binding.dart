import 'package:get/get.dart';
import 'package:gold_health/apps/controls/getOldController.dart';
import 'package:gold_health/apps/controls/getWeight_controller.dart';

import '../controls/fillProfilControls.dart';

class GetWeightB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetWeightC>(() => GetWeightC());
  }
}

import 'package:get/get.dart';
import 'package:gold_health/apps/controls/select_genderControls.dart';

class SelectGenderB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectGenderC>(() => SelectGenderC());
  }
}

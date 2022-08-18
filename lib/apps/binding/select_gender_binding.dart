import 'package:get/get.dart';
import 'package:gold_health/apps/controls/basic_controller/select_gender_controller.dart';

class SelectGenderB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectGenderC>(() => SelectGenderC());
  }
}

import 'package:get/get.dart';
import 'package:gold_health/apps/controls/basic_controller/basic_info_controller.dart';

class BasicInfoB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BasicInfoC>(() => BasicInfoC());
  }
}

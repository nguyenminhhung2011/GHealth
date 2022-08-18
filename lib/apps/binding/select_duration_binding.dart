import 'package:get/get.dart';

import '../controls/basic_controller/select_duration_controller.dart';

class SelectDurationB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectDurationC>(() => SelectDurationC());
  }
}

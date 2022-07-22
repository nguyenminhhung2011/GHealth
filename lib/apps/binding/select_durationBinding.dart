import 'package:get/get.dart';

import '../controls/select_durationControls.dart';

class SelectDurationB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectDurationC>(() => SelectDurationC());
  }
}

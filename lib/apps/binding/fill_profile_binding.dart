import 'package:get/get.dart';

import '../controls/fill_profile_controller.dart';

class FillProfileB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FillProfileC>(() => FillProfileC());
  }
}

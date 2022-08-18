import 'package:get/get.dart';
import 'package:gold_health/apps/controls/get_old_controller.dart';

import '../controls/fill_profile_controller.dart';

class GetOldB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetOldC>(() => GetOldC());
  }
}

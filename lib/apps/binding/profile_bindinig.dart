import 'package:get/get.dart';
import 'package:gold_health/apps/controls/login_controller.dart';
import 'package:gold_health/apps/controls/profile_controller.dart';

import '../controls/auth_controller.dart';

class ProfileB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileC>(() => ProfileC());
  }
}

import 'package:get/get.dart';
import 'package:gold_health/apps/controls/login_controller.dart';

import '../controls/auth_controller.dart';

class LogInB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogInC>(() => LogInC());
    Get.lazyPut<AuthC>(() => AuthC());
  }
}

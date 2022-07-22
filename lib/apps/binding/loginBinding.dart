import 'package:get/get.dart';
import 'package:gold_health/apps/controls/LoginControls.dart';

class LogInB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogInC>(() => LogInC());
  }
}

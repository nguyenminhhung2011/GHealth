import 'package:get/get.dart';
import 'package:gold_health/apps/controls/splash_controller.dart';

class SplashB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashC>(() => SplashC());
  }
}

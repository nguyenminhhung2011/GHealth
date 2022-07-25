import 'package:get/get.dart';
import 'package:gold_health/apps/controls/home_screen_control.dart';

class HomeScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeScreenControl>(() => HomeScreenControl());
  }
}

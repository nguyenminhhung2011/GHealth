import 'package:get/get.dart';

import '../controls/home_screen_control.dart';
import '../controls/dashboard_control.dart';

class DashBoardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeScreenControl>(() => HomeScreenControl());
    Get.lazyPut<DashBoardControl>(() => DashBoardControl());
  }
}

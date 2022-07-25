import 'package:get/get.dart';

import '../controls/dashboard_control.dart';

class DashBoardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashBoardControl>(() => DashBoardControl());
  }
}

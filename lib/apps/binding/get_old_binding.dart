import 'package:get/get.dart';
import 'package:gold_health/apps/controls/basic_controller/get_old_controller.dart';

class GetOldB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetOldC>(() => GetOldC());
  }
}

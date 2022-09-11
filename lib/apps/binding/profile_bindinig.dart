import 'package:get/get.dart';
import 'package:gold_health/apps/controls/profile_controller.dart';

class ProfileB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileC>(() => ProfileC());
  }
}

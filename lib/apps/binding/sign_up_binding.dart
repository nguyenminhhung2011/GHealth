import 'package:get/get.dart';
import 'package:gold_health/apps/controls/sign_up_controller.dart';

class SignUpB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpC>(() => SignUpC());
  }
}

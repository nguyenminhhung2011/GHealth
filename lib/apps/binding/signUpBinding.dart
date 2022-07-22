import 'package:get/get.dart';
import 'package:gold_health/apps/controls/LoginControls.dart';
import 'package:gold_health/apps/controls/signUpControls.dart';

class SignUpB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpC>(() => SignUpC());
  }
}

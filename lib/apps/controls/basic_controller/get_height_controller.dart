import 'package:get/get.dart';
import 'package:gold_health/apps/controls/sign_up_controller.dart';

import 'basic_controller.dart';

class GetHeightC extends GetxController with BasicController {
  RxInt height = 100.obs;
  final signUpC = Get.find<SignUpC>();
  var list = [for (var i = 100; i <= 300; i++) i];
  @override
  // void OnInit() {
  //   super.onInit();
  // }

  void nextBtnClick() {
    signUpC.basicProfile!.value.height = height.value;
    print(signUpC.basicProfile!.value.height);
    changeTab(4);
    // Get.toNamed(RouteName.getHeight);
  }
}

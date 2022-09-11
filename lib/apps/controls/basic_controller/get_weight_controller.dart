import 'package:get/get.dart';
import 'package:gold_health/apps/controls/sign_up_controller.dart';

import 'basic_controller.dart';

class GetWeightC extends GetxController with BasicController {
  RxInt weight = 1.obs;
  final signUpC = Get.find<SignUpC>();
  var list = [for (var i = 1; i <= 200; i++) i];
  @override
  // void OnInit() {
  //   super.onInit();
  // }

  void nextBtnClick() {
    signUpC.basicProfile!.value.weight = weight.value;
    print(signUpC.basicProfile!.value.weight);
    changeTab(5);
  }
}

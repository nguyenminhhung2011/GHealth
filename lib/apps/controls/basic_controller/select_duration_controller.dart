import 'package:get/get.dart';
import 'package:gold_health/apps/controls/sign_up_controller.dart';

import '../../data/enums/app_enums.dart';
import 'basic_controller.dart';

class SelectDurationC extends GetxController with BasicController {
  late Rx<Times> duration = Times.little.obs; // -1 female 0 none 1 male
  final signUpC = Get.find<SignUpC>();
  @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onClose() {
    duration.value = Times.little;
    super.onClose();
  }

  void nextBtnClick() {
    if (duration.value != null) {
      signUpC.basicProfile!.value.duration = duration.value;
      changeTab(6);
    }
  }
}

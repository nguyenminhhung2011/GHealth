import 'package:get/get.dart';
import 'package:gold_health/apps/controls/sign_up_controller.dart';

import 'basic_controller.dart';

class GetOldC extends GetxController with BasicController {
  late DateTime timePicker = DateTime.now();
  final signUpC = Get.find<SignUpC>();
  @override
  void OnInit() {
    super.onInit();
    timePicker = DateTime.now();
  }

  @override
  void onClose() {
    timePicker = DateTime.now();
    super.onClose();
  }

  void nextBtnClick() {
    signUpC.basicProfile!.value.dateOfBirth = timePicker;
    print(signUpC.basicProfile!.value.dateOfBirth.toString());
    changeTab(3);
  }
}

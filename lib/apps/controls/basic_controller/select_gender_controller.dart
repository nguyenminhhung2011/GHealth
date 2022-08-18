import 'package:get/get.dart';
import 'package:gold_health/apps/controls/basic_controller/basic_info_controller.dart';
import 'package:gold_health/apps/controls/sign_up_controller.dart';
import 'package:gold_health/apps/global_widgets/dialog/error_dialog.dart';

import '../../data/enums/app_enums.dart';
import 'basic_controller.dart';

class SelectGenderC extends GetxController with BasicController {
  late Rx<Gender> select = Gender.female.obs; // -1 female 0 none 1 male
  final signUpC = Get.find<SignUpC>();
  @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onClose() {
    select.value = Gender.female;
    super.onClose();
  }

  void nextBtnClick() {
    if (select.value != null) {
      signUpC.basicProfile!.value.gender = select.value;
      changeTab(2);
    } else {
      Get.dialog(const ErrorDialog(
          question: 'Create Account', title1: 'Gender is not null'));
    }
  }
}

import 'package:get/get.dart';
import 'package:gold_health/apps/controls/basic_controller/basic_info_controller.dart';
import 'package:gold_health/apps/controls/sign_up_controller.dart';
import 'package:gold_health/apps/global_widgets/dialog/error_dialog.dart';

import '../../data/enums/app_enums.dart';
import '../../routes/route_name.dart';

class SelectGenderC extends GetxController {
  late Rx<Gender> select = Gender.female.obs; // -1 female 0 none 1 male
  final basicInfoC = Get.find<BasicInfoC>();
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
      basicInfoC.signUpC.basicProfile!.value.gender = select.value;
      basicInfoC.pageChange(2);
    } else {
      Get.dialog(const ErrorDialog(
          question: 'Create Account', title1: 'Gender is not null'));
    }
  }
}

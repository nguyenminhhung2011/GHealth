import 'package:get/get.dart';
import 'package:gold_health/apps/controls/signUpControls.dart';

import '../data/enums/app_enums.dart';
import '../routes/routeName.dart';

class SelectGenderC extends GetxController {
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
      Get.toNamed(RouteName.getOld);
    }
  }
}

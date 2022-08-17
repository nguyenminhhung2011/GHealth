import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gold_health/apps/controls/signUpControls.dart';

import '../routes/routeName.dart';

class GetOldC extends GetxController {
  late DateTime timePicker = DateTime.now();
  final signUpC = Get.find<SignUpC>();
  @override
  void OnInit() {
    super.onInit();
    timePicker = DateTime.now();
  }

  void nextBtnClick() {
    signUpC.basicProfile!.value.dateOfBirth = timePicker;
    print(signUpC.basicProfile!.value.dateOfBirth.toString());
    Get.toNamed(RouteName.getWeight);
  }
}

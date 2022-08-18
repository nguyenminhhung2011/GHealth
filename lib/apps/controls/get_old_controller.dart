import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gold_health/apps/controls/basic_info_controller.dart';
import 'package:gold_health/apps/controls/sign_up_controller.dart';

import '../routes/route_name.dart';

class GetOldC extends GetxController {
  late DateTime timePicker = DateTime.now();
  final basicInfoC = Get.find<BasicInfoC>();
  @override
  void OnInit() {
    super.onInit();
    timePicker = DateTime.now();
  }

  void nextBtnClick() {
    basicInfoC.signUpC.basicProfile!.value.dateOfBirth = timePicker;
    print(basicInfoC.signUpC.basicProfile!.value.dateOfBirth.toString());
    basicInfoC.pageChange(3);
  }
}

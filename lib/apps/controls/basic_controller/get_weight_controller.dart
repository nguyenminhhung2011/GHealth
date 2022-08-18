import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gold_health/apps/controls/sign_up_controller.dart';

import '../../routes/route_name.dart';
import 'basic_info_controller.dart';

class GetWeightC extends GetxController {
  RxInt weight = 1.obs;
  final basicInfoC = Get.find<BasicInfoC>();
  var list = [for (var i = 1; i <= 200; i++) i];
  @override
  // void OnInit() {
  //   super.onInit();
  // }

  void nextBtnClick() {
    basicInfoC.signUpC.basicProfile!.value.weight = weight.value;
    print(basicInfoC.signUpC.basicProfile!.value.weight);
    basicInfoC.pageChange(4);
  }
}

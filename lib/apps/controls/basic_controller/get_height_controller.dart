import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gold_health/apps/controls/sign_up_controller.dart';

import '../../routes/route_name.dart';
import 'basic_info_controller.dart';

class GetHeightC extends GetxController {
  RxInt height = 100.obs;
  final basicInfoC = Get.find<BasicInfoC>();
  var list = [for (var i = 100; i <= 300; i++) i];
  @override
  // void OnInit() {
  //   super.onInit();
  // }

  void nextBtnClick() {
    basicInfoC.signUpC.basicProfile!.value.height = height.value;
    print(basicInfoC.signUpC.basicProfile!.value.height);
    basicInfoC.pageChange(5);
    // Get.toNamed(RouteName.getHeight);
  }
}

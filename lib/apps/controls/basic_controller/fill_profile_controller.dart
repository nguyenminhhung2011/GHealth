import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/sign_up_controller.dart';

import 'basic_controller.dart';

class FillProfileC extends GetxController with BasicController {
  late TextEditingController fullName;
  late TextEditingController nickName;
  late TextEditingController phoneNo;
  final signUpC = Get.find<SignUpC>();
  @override
  void onInit() {
    super.onInit();
    fullName = TextEditingController();
    nickName = TextEditingController();
    phoneNo = TextEditingController();
  }
}

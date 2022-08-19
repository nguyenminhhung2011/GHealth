import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/auth_controller.dart';
import 'package:gold_health/apps/controls/sign_up_controller.dart';
import 'package:gold_health/apps/global_widgets/dialog/yes_no_dialog.dart';
import 'package:gold_health/constains.dart';
import 'package:intl/intl.dart';

import '../../data/enums/app_enums.dart';
import 'basic_controller.dart';
import 'basic_info_controller.dart';

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

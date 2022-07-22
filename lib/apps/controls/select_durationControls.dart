import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectDurationC extends GetxController {
  late TextEditingController emailC;
  late TextEditingController passC;
  late int select; // 0: none, 1: sometimes , 2: usually, 3: always

  @override
  void onInit() {
    super.onInit();
    select = 0;
    emailC = TextEditingController();
    passC = TextEditingController();
  }

  @override
  void onClose() {
    select = 0;
    emailC.dispose();
    passC.dispose();
    super.onClose();
  }
}

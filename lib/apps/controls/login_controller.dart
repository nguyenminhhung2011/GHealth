import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInC extends GetxController {
  late TextEditingController emailC;
  late TextEditingController passC;
  RxString gifString = 'assets/gift/download.gif'.obs;
  @override
  void onInit() {
    super.onInit();
    emailC = TextEditingController();
    passC = TextEditingController();
  }

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();

    super.onClose();
  }
}

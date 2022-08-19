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
    emailC.text = 'h@gmail.com';
    passC.text = '1234567';
  }

  @override
  void disposeAll() {
    emailC.dispose();
    passC.dispose();
  }

  void onClose() {
    // emailC.dispose();
    // passC.dispose();
    super.onClose();
  }
}

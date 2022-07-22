import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpC extends GetxController {
  late TextEditingController emailC;
  late TextEditingController passC;
  late TextEditingController repassC;

  @override
  void onInit() {
    super.onInit();
    emailC = TextEditingController();
    passC = TextEditingController();
    repassC = TextEditingController();
  }

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    repassC.dispose();
    super.onClose();
  }
}

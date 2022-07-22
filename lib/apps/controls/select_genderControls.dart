import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectGenderC extends GetxController {
  late TextEditingController emailC;
  late TextEditingController passC;
  late int select; // -1 female 0 none 1 male

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

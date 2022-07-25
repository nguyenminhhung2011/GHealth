import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenControl extends GetxController {
  late TextEditingController userName;

  @override
  void onClose() {
    userName.dispose();
    super.onClose();
  }
}

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../constrains.dart';

class DashBoardControl extends GetxController {
  var tabIndex = 0.obs;
  var pageController = PageController();
  @override
  void onInit() {
    super.onInit();
    tabIndex.value = 0;
  }

  @override
  void onClose() {
    tabIndex.value = 0;
    super.onClose();
  }
}

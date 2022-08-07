import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyPlanController extends GetxController {
  static const int nutrition = 0;
  static const int workout = 1;
  static const int water = 2;
  static const int step = 3;
  static const int fasting = 4;

  Rx<int> currentTab = nutrition.obs;

  void changeTab(int newTabIndex) {
    int currentIndex = currentTab.value;
    if (currentIndex == newTabIndex) return;
    switch (currentIndex) {
    }
    currentTab.value = newTabIndex;
  }

  Widget getCurrentTab() {
    int index = currentTab.value;

    return Container();
  }
}

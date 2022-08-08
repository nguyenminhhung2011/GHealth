import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controls/dailyPlanController/DailyPlanControls.dart';

class DailyPlanScreen extends StatelessWidget {
  DailyPlanScreen({Key? key}) : super(key: key);
  final controller = Get.find<DailyPlanController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.getCurrentTab());
  }
}

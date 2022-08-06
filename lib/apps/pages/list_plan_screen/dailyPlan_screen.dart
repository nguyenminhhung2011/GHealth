import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controls/DailyPlanControls.dart';

class DailyPlan extends StatelessWidget {
  DailyPlan({Key? key}) : super(key: key);
  final controller = Get.find<DailyPlanController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.getCurrentTab());
  }
}

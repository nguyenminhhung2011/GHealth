import 'package:get/get.dart';

import '../controls/today_schedule_controller.dart';

class TodayScheduleB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodayScheduleC>(() => TodayScheduleC());
  }
}

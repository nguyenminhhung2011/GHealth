import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/daily_plan_controller.dart';

abstract class TrackerController {
  final _parentController = Get.find<DailyPlanController>();
  late DateTime date;

  RxBool isLoading = false.obs;

  void changeTab(int value) {
    _parentController.changeTab(value);
  }

  // fetchTracksByDate(DateTime date);
}

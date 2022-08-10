import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/tracker_controller.dart';

class DailyStepController extends GetxController with TrackerController {
  RxList<Map<String, dynamic>> stepWeek = <Map<String, dynamic>>[].obs;
  Rx<int> stepTarget = 4000.obs;
  Rx<int> stepConsume = 200.obs;
}

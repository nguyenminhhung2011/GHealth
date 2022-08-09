import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/tracker_controller.dart';

class DailyWaterController extends GetxController with TrackerController {
  RxList<Map<String, dynamic>> waterConsumer = <Map<String, dynamic>>[].obs;
}

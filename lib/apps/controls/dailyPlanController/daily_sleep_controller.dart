import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/tracker_controller.dart';

import '../../../services/data_service.dart';
import '../../data/models/sleep.dart';

class DailySleepController extends GetxController with TrackerController {
  RxList<Map<String, dynamic>> stepWeek = <Map<String, dynamic>>[].obs;
  Map<String, dynamic> get sleepBasictime =>
      DataService.instance.sleepBasicTIme;
  Map<String, dynamic> get sleepBasicTime =>
      DataService.instance.sleepBasicTIme;
  List<Sleep> get listSleep => DataService.instance.listSleepTime;
  List<Sleep> get listSleepToday => [
        for (var item in DataService.instance.listSleepTime)
          if (item.listDate.contains(DateTime.now().weekday)) item
      ];
}

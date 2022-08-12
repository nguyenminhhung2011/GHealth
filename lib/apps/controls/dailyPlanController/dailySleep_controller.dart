import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/tracker_controller.dart';

class DailySleepController extends GetxController with TrackerController {
  RxList<Map<String, dynamic>> stepWeek = <Map<String, dynamic>>[].obs;

  var listSchedule = ([
    {
      'name': 'Bedtime',
      'icon': 'assets/images/bed.png',
      'time': DateTime(2022, 8, 5, 21),
      'isTurnOn': true,
    },
    {
      'name': 'Alarm',
      'icon': 'assets/images/Icon-Alaarm.png',
      'time': DateTime(2022, 8, 5, 5, 10),
      'isTurnOn': true,
    },
  ] as List<Map<String, dynamic>>)
      .obs;
}

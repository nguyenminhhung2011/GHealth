import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/tracker_controller.dart';

class DailyWaterController extends GetxController with TrackerController {
  RxList<Map<String, dynamic>> waterConsumeToday = <Map<String, dynamic>>[].obs;
  Rx<int> waterTarget = 4000.obs;
  Rx<int> waterConsume = 200.obs;

  updateWaterTargetAndConsume(int value1, int value2) async {
    waterTarget.value = value1;
    waterConsume.value += value2;
    if (value2 != 0) {
      waterConsumeToday.value.add({
        'date':
            '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
        'time': '${DateTime.now().hour}:${DateTime.now().minute}',
        'ml': value2
      });
    }
    update();
  }
}

import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/tracker_controller.dart';

class DailyStepController extends GetxController with TrackerController {
  RxList<Map<String, dynamic>> stepWeek = <Map<String, dynamic>>[].obs;
  Rx<int> stepTarget = 3000.obs;
  Rx<int> stepConsume = 0.obs;
  Rx<double> caoloriesToday = 0.0.obs;
  Rx<double> milesToday = 0.0.obs;
  Rx<double> durationToday = 0.0.obs;

  // // void calculate data
  double calculateMiles(int steps) {
    double milesValue = (2.2 * steps) / 5280;
    return milesValue;
  }

  double calculateDuration(int steps) {
    double durationValue = (steps * 1 / 1000);
    return durationValue;
  }

  double calculateCalories(int steps) {
    double caloriesValue = (steps * 0.0566);
    return caloriesValue;
  }

  saveData(int step, double calo, double miles, double duration) {
    stepConsume.value += step;
    milesToday.value += miles;
    caoloriesToday.value += calo;
    durationToday.value += duration;
    update();
  }
}

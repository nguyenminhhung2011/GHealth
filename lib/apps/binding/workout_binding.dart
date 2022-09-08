import 'package:get/get.dart';
import 'package:gold_health/apps/controls/workout_controller/workout_plan_controller.dart';

class WorkoutBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkoutPlanController>(() => WorkoutPlanController());
  }
}

import 'package:get/get.dart';

class WorkoutControllerCounter extends GetxController {
  late Rx<Duration> timeCounter;
  RxInt currentWorkoutIndex = 0.obs;
}

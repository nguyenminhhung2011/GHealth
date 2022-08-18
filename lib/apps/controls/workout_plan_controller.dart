import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/tracker_controller.dart';

import 'dailyPlanController/daily_plan_controller.dart';

class WorkoutPlanController extends GetxController with TrackerController {
  TextEditingController text = TextEditingController();
  RxInt allTime = 60.obs;
  RxInt isReady = 1.obs;
  RxInt currentWorkoutIndex = 0.obs;
  RxList<Map<String, dynamic>> listWorkout = [
    {
      'name': 'Jumping Jacks',
      'time': 20,
      'ready': 10,
      'calo': 300,
    },
    {
      'name': 'Warm Up',
      'time': 20,
      'ready': 10,
      'calo': 400,
    }
  ].obs;
}

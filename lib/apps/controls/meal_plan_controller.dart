import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/tracker_controller.dart';

import 'dailyPlanController/daily_plan_controller.dart';

class MealPlanController extends GetxController with TrackerController {
  TextEditingController text = TextEditingController();
  RxList<Map<String, dynamic>> todayListMeal = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> listMealBreakFast = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> listMealLuch = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> listMealDinner = <Map<String, dynamic>>[].obs;

  //@override
  // fetchTracksByDate(DateTime date) {
  //   // TODO: implement fetchTracksByDate
  //   throw UnimplementedError();
  // }
}

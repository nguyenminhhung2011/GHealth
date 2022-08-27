import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../data/models/Meal.dart';

class MealScheduleC extends GetxController {
  TextEditingController controller = TextEditingController();
  final Rx<int> _onFocus = 1.obs;
  int get onFocus => _onFocus.value;
  final Rx<CalendarController> _calendarController = CalendarController().obs;
  CalendarController get calendarController => _calendarController.value;
  Rx<Map<String, dynamic>> mealDate = Rx<Map<String, dynamic>>({});
  List<Meal> allMeal = Get.arguments['allMeal'];
  List<Map<String, dynamic>> mealPlan = Get.arguments['mealPlan'];

  Rx<int> calories = 0.obs;
  Rx<int> proteins = 0.obs;
  Rx<int> fats = 0.obs;
  Rx<int> carbo = 0.obs;

  RxList<int> listCalories = [0, 0, 0, 0].obs;
  final List<DateTime> listDateTime = [
    for (int i = 1; i <= 30; i++)
      DateTime(2022, 8, 1).subtract(Duration(days: i)),
    for (int i = 0; i <= 30; i++) DateTime(2022, 8, 1).add(Duration(days: i))
  ];
  @override
  void onInit() {
    super.onInit();
    _calendarController.value = CalendarController();
    getMealDate(DateTime.now().weekday);
    update();
  }

  //Function

  focusDegree(DateTime time) {
    _onFocus.value--;
    _calendarController.value.displayDate = time;
    getMealDate(time.weekday);
    update();
  }

  focusePluss(DateTime time) {
    _onFocus.value++;
    _calendarController.value.displayDate = time;
    getMealDate(time.weekday);
    update();
  }

  setFocus(int index, DateTime time) {
    _onFocus.value = index;
    _calendarController.value.displayDate = time;
    getMealDate(time.weekday);

    update();
  }

  setFocus1(int index) {
    _onFocus.value = index;
    getMealDate(listDateTime[index].weekday);
    update();
  }

  Meal getMealId(String id, List<Meal> l) {
    final meal = l.firstWhere(
      (element) => element.id == id,
      orElse: () {
        return l[0];
      },
    );
    return meal;
  }

  getMealDate(int weekDay) async {
    final listMealId = mealPlan.firstWhere(
      (element) => element['id'] == weekDay,
    );
    List<Meal> lbreak = [];
    List<Meal> llunch = [];
    List<Meal> lsnack = [];
    List<Meal> ldinner = [];
    listCalories.value = [0, 0, 0, 0].obs;
    for (var item in listMealId['listMealBreak']) {
      Meal temp = getMealId(item, allMeal);
      carbo.value += temp.carbs;
      proteins.value += temp.proteins;
      fats.value += temp.fats;
      calories.value += temp.kCal;
      listCalories.value[0] += temp.kCal;
      lbreak.add(temp);
    }
    for (var item in listMealId['listMealLunch']) {
      Meal temp = getMealId(item, allMeal);
      carbo.value += temp.carbs;
      proteins.value += temp.proteins;
      fats.value += temp.fats;
      calories.value += temp.kCal;
      listCalories.value[1] += temp.kCal;
      llunch.add(temp);
    }
    for (var item in listMealId['listSnack']) {
      Meal temp = getMealId(item, allMeal);
      carbo.value += temp.carbs;
      proteins.value += temp.proteins;
      fats.value += temp.fats;
      calories.value += temp.kCal;
      listCalories.value[2] += temp.kCal;
      lsnack.add(temp);
    }
    for (var item in listMealId['listMealDinner']) {
      Meal temp = getMealId(item, allMeal);
      carbo.value += temp.carbs;
      proteins.value += temp.proteins;
      fats.value += temp.fats;
      calories.value += temp.kCal;
      listCalories.value[3] += temp.kCal;
      ldinner.add(temp);
    }
    mealDate.value = {
      'BreakFast': lbreak,
      'Lunch': llunch,
      'Snack': lsnack,
      'Dinner': ldinner,
    };
    update();
  }
}

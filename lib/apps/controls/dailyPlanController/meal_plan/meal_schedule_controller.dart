import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/constrains.dart';
import 'package:gold_health/services/auth_service.dart';
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
  List<DateTime> timeEat = Get.arguments['timeEat'];

  Rx<int> calories = 0.obs;
  Rx<int> proteins = 0.obs;
  Rx<int> fats = 0.obs;
  Rx<int> carbo = 0.obs;
  initNutri() {
    calories.value = 0;
    proteins.value = 0;
    fats.value = 0;
    carbo.value = 0;
    update();
  }

  RxList<int> listCalories = [0, 0, 0, 0].obs;
  RxList<int> listNutritionConsume = [0, 0, 0, 0].obs;
  // --> kcal, proteins, fats, carbo

  final List<DateTime> listDateTime = [
    for (int i = 1; i <= 30; i++) DateTime.now().subtract(Duration(days: i)),
    for (int i = 0; i <= 30; i++) DateTime.now().add(Duration(days: i))
  ];
  @override
  void onInit() {
    super.onInit();
    _calendarController.value = CalendarController();
    getMealDate(DateTime.now());
    getNutriData(DateTime.now());
    update();
  }

  //Function

  focusDegree(DateTime time) {
    _onFocus.value--;
    _calendarController.value.displayDate = time;
    getMealDate(time);
    getNutriData(time);
    update();
  }

  focusePluss(DateTime time) {
    _onFocus.value++;
    _calendarController.value.displayDate = time;
    getMealDate(time);
    getNutriData(time);
    update();
  }

  setFocus(int index, DateTime time) {
    _onFocus.value = index;
    _calendarController.value.displayDate = time;
    getMealDate(time);
    getNutriData(listDateTime[index]);
    update();
  }

  setFocus1(int index) {
    _onFocus.value = index;
    getMealDate(listDateTime[index]);
    getNutriData(listDateTime[index]);
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
  // --> kcal, proteins, fats, carbo

  getNutriData(DateTime date) async {
    listNutritionConsume.bindStream(firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('Nutrition')
        .snapshots()
        .map((event) {
      List<int> result = [0, 0, 0, 0];
      for (var item in event.docs) {
        DateTime dateTemp = DateTime.fromMillisecondsSinceEpoch(
            item.data()['dateTime'].seconds * 1000);
        if (dateTemp.year == date.year &&
            dateTemp.month == date.month &&
            dateTemp.day == date.day) {
          Meal m = getMealId(item.data()['id'], allMeal);
          result[0] += m.kCal;
          result[1] += m.proteins;
          result[2] += m.fats;
          result[3] += m.carbs;
        }
      }
      return result;
    }));
    update();
  }

  getMealDate(DateTime date) async {
    int weekDay = date.weekday;
    final listMealId = mealPlan.firstWhere(
      (element) => element['id'] == weekDay,
    );
    List<Meal> lbreak = [];
    List<Meal> llunch = [];
    List<Meal> lsnack = [];
    List<Meal> ldinner = [];
    initNutri();
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

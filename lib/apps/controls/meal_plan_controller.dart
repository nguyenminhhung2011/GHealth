import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/tracker_controller.dart';
import 'package:gold_health/apps/data/models/nutrition.dart';
import 'package:gold_health/constrains.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../services/auth_service.dart';
import '../../services/data_service.dart';
import '../data/models/Meal.dart';

class MealPlanController extends GetxController with TrackerController {
  //Data

  List<String> mealPlan = [
    'BreakFast',
    'Lunch',
    'Snack',
    'Dinner',
  ];

  Rx<String> selectPlan = 'BreakFast'.obs;

  int get planInt => (selectPlan.value == 'BreakFast')
      ? 0
      : (selectPlan.value == 'Lunch')
          ? 1
          : (selectPlan.value == "Snack")
              ? 2
              : 3;

  final Rx<List<FlSpot>> _listDataChart = Rx<List<FlSpot>>([]);
  // final Rx<List<Nutrition>> _listNutrition = Rx<List<Nutrition>>([]);
  final Rx<List<Map<String, dynamic>>> _listWeekNutriton =
      Rx<List<Map<String, dynamic>>>([]);

  final Rx<int> weekdayNutriFocus = 2.obs;
  DateTime selectDateTemp1 = DateTime.now();
  DateTime selectDateTemp2 = DateTime.now();

  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> finishDate = DateTime.now().obs;
  DateRangePickerController dateController = DateRangePickerController();

  RxList<DateTime> allDateBetWeen = <DateTime>[].obs;

  List<Map<String, dynamic>> get listDataNutriPlan =>
      DataService.instance.dataNutriPlan;
  // Rx<List<Map<String, dynamic>>>([]);
  List<Meal> get listMealLunch => DataService.instance.mealLunchDinnerList;
  List<Meal> get allMeal => DataService.instance.mealList;
  List<Meal> get listMealBreakFast => DataService.instance.mealBreakFastList;
  List<Meal> get listMealSnack => DataService.instance.mealSnackList;
  List<Nutrition> get listNutrition => DataService.instance.nutritionList;

  List<DateTime> get timeEat => DataService.instance.timeEatList;

  List<FlSpot> get listDataChart => _listDataChart.value;
  List<Map<String, dynamic>> get listWeekNutrition => _listWeekNutriton.value;
  Rx<Map<String, dynamic>> mealToday = Rx<Map<String, dynamic>>({});

  List<Map<String, dynamic>> listMealPlan = [];
  @override
  void onInit() {
    super.onInit();
    getStartDateAndFinishDate();
    getMealToDay();
    getDataChart(1);
    dateController = DateRangePickerController();
  }

  TextEditingController text = TextEditingController();
  RxList<Map<String, dynamic>> todayListMeal = <Map<String, dynamic>>[].obs;

  //date controller-----------------

  bool isSameDate(DateTime date1, DateTime date2) {
    if (date2 == date1) {
      return true;
    }
    if (date1 == null || date2 == null) {
      return false;
    }
    return date1.month == date2.month &&
        date1.year == date2.year &&
        date1.day == date2.day;
  }

  // change date select
  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    int firstDayOfWeek = DateTime.sunday % 7;
    int endDayOfWeek = (firstDayOfWeek - 1) % 7;
    endDayOfWeek = endDayOfWeek < 0 ? 7 + endDayOfWeek : endDayOfWeek;
    PickerDateRange ranges = args.value;
    DateTime date1 = ranges.startDate!;
    DateTime date2 = (ranges.endDate ?? ranges.startDate)!;
    if (date1.isAfter(date2)) {
      var date = date1;
      date1 = date2;
      date2 = date;
    }
    int day1 = date1.weekday % 7;
    int day2 = date2.weekday % 7;

    DateTime dat1 = date1.add(Duration(days: (firstDayOfWeek - day1)));
    DateTime dat2 = date2.add(Duration(days: (endDayOfWeek - day2)));

    if (!isSameDate(dat1, ranges.startDate!) ||
        !isSameDate(dat2, ranges.endDate!)) {
      dateController.selectedRange = PickerDateRange(dat1, dat2);
      selectDateTemp1 = dat1;
      selectDateTemp2 = dat2;
    }
  }

  //load data chart with select calendar
  selectDateDoneClick() {
    startDate.value = selectDateTemp1;
    finishDate.value = selectDateTemp2;
    allDateBetWeen.value = getListDateBetWeenRange();
    getDataChart(0);
    update();
  }

  // get number date between
  getDayInBetWeen() {
    final int difference = finishDate.value.difference(startDate.value).inDays;
    return difference;
  }

  //get list date to load chart
  List<DateTime> getListDateBetWeenRange() {
    final items = List<DateTime>.generate(getDayInBetWeen() + 1, (index) {
      DateTime date = startDate.value;
      return date.add(Duration(days: index));
    });
    return items;
  }

  //get date start and date finish to load chart
  void getStartDateAndFinishDate() {
    DateTime now = DateTime.now();
    int weekDay = now.weekday == 7 ? 0 : now.weekday;
    startDate.value = DateTime.now();
    finishDate.value = DateTime.now();
    for (int i = 0; i < weekDay; i++) {
      startDate.value = startDate.value.add(const Duration(days: -1));
    }
    for (int i = 0; i < 6 - weekDay; i++) {
      finishDate.value = finishDate.value.add(const Duration(days: 1));
    }
    allDateBetWeen.value = List<DateTime>.generate(
        7, (index) => startDate.value.add(Duration(days: index)));
    update();
  }

  //-----------------------Chart-----------------

  updateweekdayNutriFocus(double selected) {
    weekdayNutriFocus.value = selected.toInt();
    update();
  }

  bool checkDateInList(DateTime date) {
    for (var item in allDateBetWeen.value) {
      if (date.day == item.day &&
          date.month == item.month &&
          date.year == item.year) return true;
    }
    return false;
  }

  // get data to load chart
  getDataChart(int check) async {
    _listWeekNutriton.bindStream(firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('Nutrition')
        .snapshots()
        .map((event) {
      List<Map<String, dynamic>> result = [
        for (var item in allDateBetWeen.value)
          {
            'id': item.weekday,
            'kCal': 0,
            'carbs': 0,
            'pro': 0,
            'fats': 0,
          }
      ];
      result.sort((a, b) => a['id'].compareTo(b['id']));
      for (var item in event.docs) {
        Nutrition data = Nutrition.fromSnap(item);
        if (checkDateInList(data.dateTime)
            // allDateBetWeen.value[0].isBefore(data.dateTime) &&
            //   allDateBetWeen.value[6].isAfter(data.dateTime)
            ) {
          result[data.dateTime.weekday - 1]['kCal'] +=
              data.amount * getMealId(data.id, allMeal).kCal;
          result[data.dateTime.weekday - 1]['carbs'] +=
              data.amount * getMealId(data.id, allMeal).carbs;
          result[data.dateTime.weekday - 1]['pro'] +=
              data.amount * getMealId(data.id, allMeal).proteins;
          result[data.dateTime.weekday - 1]['fats'] +=
              data.amount * getMealId(data.id, allMeal).fats;
        }
      }
      return result;
    }));
    update();
  }

  //------------------------------------------------------
  Meal getMealId(String id, List<Meal> l) {
    // get meal from id String
    final meal = l.firstWhere(
      (element) => element.id == id,
      orElse: () {
        return l[0];
      },
    );
    return meal;
  }

  // get meal plan today
  getMealToDay() async {
    final listPlan = await firestore.collection('PlanMeal').get();
    final list = listPlan.docs;
    listMealPlan = List<Map<String, dynamic>>.generate(
        list.length, (index) => list[index].data());
    int weekDay = DateTime.now().weekday;
    final getListMealIdQuery = list.firstWhere(
      (element) => element.data()['id'] == weekDay,
    );
    final listMealId = getListMealIdQuery.data();
    List<Meal> lbreak = [];
    List<Meal> llunch = [];
    List<Meal> lsnack = [];
    List<Meal> ldinner = [];
    final allMeal1 = await firestore.collection('meal').get();
    final listMeal = allMeal1.docs;
    List<Meal> allMealData = [];
    for (var item in listMeal) {
      allMealData.add(Meal.fromSnap(item));
    }
    for (var item in listMealId['listMealBreak']) {
      lbreak.add(getMealId(item, allMealData));
    }
    for (var item in listMealId['listMealLunch']) {
      llunch.add(getMealId(item, allMealData));
    }
    for (var item in listMealId['listSnack']) {
      lsnack.add(getMealId(item, allMealData));
    }
    for (var item in listMealId['listMealDinner']) {
      ldinner.add(getMealId(item, allMealData));
    }
    mealToday.value = {
      'BreakFast': lbreak,
      'Lunch': llunch,
      'Snack': lsnack,
      'Dinner': ldinner,
    };
    update();
  }

  selectMealPlan(String value) {
    selectPlan.value = value;
    update();
  }
}

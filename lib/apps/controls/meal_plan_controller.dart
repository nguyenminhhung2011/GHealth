// ignore_for_file: unnecessary_null_comparison

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/tracker_controller.dart';
import 'package:gold_health/constrains.dart';
import 'package:gold_health/services/auth_service.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../data/models/Meal.dart';

class MealPlanController extends GetxController with TrackerController {
  final Rx<List<Meal>> _allMeal = Rx<List<Meal>>([]);
  final Rx<List<Meal>> _listMealBreakFast = Rx<List<Meal>>([]);
  final Rx<List<Meal>> _listMealLunch = Rx<List<Meal>>([]);
  final Rx<List<Meal>> _listMealSnack = Rx<List<Meal>>([]);
  final Rx<List<FlSpot>> _listDataChart = Rx<List<FlSpot>>([]);
  final Rx<List<Map<String, dynamic>>> _listWeekNutriton =
      Rx<List<Map<String, dynamic>>>([]);
  // [
  //   {
  //   'id': 1,
  //   'kCal': 2000,
  //   'carbs': 1000,
  //   'pro': 1000,
  //   'fats': 000
  //  }
  // ]

  List<Meal> get listMealLunch => _listMealLunch.value;
  List<Meal> get allMeal => _allMeal.value;
  List<Meal> get listMealBreakFast => _listMealBreakFast.value;
  List<Meal> get listMealSnack => _listMealSnack.value;
  List<FlSpot> get listDataChart => _listDataChart.value;
  List<Map<String, dynamic>> get listWeekNutrition => _listWeekNutriton.value;

  RxList<DateTime> timeEat = <DateTime>[
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    getAllMeal();
    getListMealBreakFast();
    getListMealLunch();
    getListMealDinner();
    getStartDateAndFinishDate();
    getMealToDay();
    getTimeEat();
    dateController = DateRangePickerController();
  }

  TextEditingController text = TextEditingController();
  RxList<Map<String, dynamic>> todayListMeal = <Map<String, dynamic>>[].obs;

  //date controller
  DateTime selectDateTemp1 = DateTime.now();
  DateTime selectDateTemp2 = DateTime.now();

  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> finishDate = DateTime.now().obs;
  DateRangePickerController dateController = DateRangePickerController();

  RxList<DateTime> allDateBetWeen = <DateTime>[].obs;

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

  selectDateDoneClick() {
    startDate.value = selectDateTemp1;
    finishDate.value = selectDateTemp2;
    allDateBetWeen.value = getListDateBetWeenRange();
    update();
  }

  getDayInBetWeen() {
    final int difference = finishDate.value.difference(startDate.value).inDays;
    return difference;
  }

  List<DateTime> getListDateBetWeenRange() {
    final items = List<DateTime>.generate(getDayInBetWeen() + 1, (index) {
      DateTime date = startDate.value;
      return date.add(Duration(days: index));
    });
    return items;
  }

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

  //-------------------------------------------------------------------

  Rx<Map<String, dynamic>> mealToday = Rx<Map<String, dynamic>>({});
  List<Map<String, dynamic>> listMealPlan = [];
  // {
  //   'break': [Meal],
  //   'lunch': [Meal],
  //   'snack': [Meal],
  //   'dinner': [Meal],
  // }
  getAllMeal() {
    _allMeal.bindStream(
      firestore.collection('meal').snapshots().map(
        (event) {
          List<Meal> result = [];
          for (var item in event.docs) {
            //print(1);
            result.add(Meal.fromSnap(item));
          }
          return result;
        },
      ),
    );
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

  selectMealPlan(String value) {
    selectPlan.value = value;
    update();
  }

  //-------------------------------------------------
  getListMealBreakFast() async {
    _listMealBreakFast.bindStream(
      firestore.collection('meal').snapshots().map(
        (event) {
          List<Meal> result = [];
          for (var item in event.docs) {
            //print(1);
            Map<String, dynamic> temp = item.data();
            if (temp['time'] == 1) {
              result.add(Meal.fromSnap(item));
            }
          }
          return result;
        },
      ),
    );
    update();
  }

  getListMealLunch() async {
    _listMealLunch.bindStream(
      firestore.collection('meal').snapshots().map(
        (event) {
          List<Meal> result = [];
          for (var item in event.docs) {
            //print(1);
            Map<String, dynamic> temp = item.data();
            if (temp['time'] == 2) {
              result.add(Meal.fromSnap(item));
            }
          }
          return result;
        },
      ),
    );
    update();
  }

  getListMealDinner() async {
    _listMealSnack.bindStream(
      firestore.collection('meal').snapshots().map(
        (event) {
          List<Meal> result = [];
          for (var item in event.docs) {
            //print(1);
            Map<String, dynamic> temp = item.data();
            if (temp['time'] == 3) {
              result.add(Meal.fromSnap(item));
            }
          }
          return result;
        },
      ),
    );
    update();
  }

  getTimeEat() async {
    timeEat.bindStream(
      firestore
          .collection('users')
          .doc(AuthService.instance.currentUser!.uid)
          .collection('timeEat')
          .snapshots()
          .map((event) {
        List<DateTime> result = [];
        Map<String, dynamic> listTime = event.docs[0].data();
        for (var item in listTime['list']) {
          result.add(DateTime.fromMillisecondsSinceEpoch(item.seconds * 1000));
        }
        return result;
      }),
    );
    update();
  }

  remove() {
    _allMeal.value.removeWhere((element) => element.name == 'Protein Oat');
    update();
  }

  // Ok() async {
  //   for (int i = 0; i < FakeData.list11.length; i++) {
  //     await firestore
  //         .collection('PlanMeal')
  //         .doc(FakeData.dayList[i])
  //         .set(FakeData.list11[i]);
  //   }
  // }
  //@override
  // fetchTracksByDate(DateTime date) {
  //   // TODO: implement fetchTracksByDate
  //   throw UnimplementedError();
  // }

}

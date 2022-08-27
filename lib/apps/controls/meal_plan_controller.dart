// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/tracker_controller.dart';
import 'package:gold_health/apps/data/fake_data.dart';
import 'package:gold_health/constrains.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../data/models/Meal.dart';

class MealPlanController extends GetxController with TrackerController {
  final Rx<List<Meal>> _listMealToday = Rx<List<Meal>>([]);
  final Rx<List<Meal>> _listMealBreakFast = Rx<List<Meal>>([]);
  final Rx<List<Meal>> _listMealLunch = Rx<List<Meal>>([]);
  final Rx<List<Meal>> _listMealDinner = Rx<List<Meal>>([]);
  List<Meal> get listMealLunch => _listMealLunch.value;
  List<Meal> get listMealToday => _listMealToday.value;
  List<Meal> get listMealBreakFast => _listMealBreakFast.value;
  List<Meal> get listMealDinner => _listMealDinner.value;
  @override
  void onInit() {
    super.onInit();
    getAllMeal();
    getListMealBreakFast();
    getListMealLunch();
    getListMealDinner();
    getStartDateAndFinishDate();
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
    update();
  }

  getDayInBetWeen() {
    final int difference = finishDate.value.difference(startDate.value).inDays;
    print(difference);
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
    DateTime now = DateTime.now().add(const Duration(days: -4));
    int weekDay = now.weekday == 7 ? 0 : now.weekday;
    startDate.value = DateTime.now().add(const Duration(days: -4));
    finishDate.value = DateTime.now().add(const Duration(days: -4));
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
  getAllMeal() async {
    _listMealToday.bindStream(
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
    _listMealDinner.bindStream(
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

  remove() {
    _listMealToday.value
        .removeWhere((element) => element.name == 'Protein Oat');
    update();
  }

  Ok() async {
    for (int i = 0; i < FakeData.list11.length; i++) {
      await firestore
          .collection('PlanMeal')
          .doc(FakeData.dayList[i])
          .set(FakeData.list11[i]);
    }
  }
  //@override
  // fetchTracksByDate(DateTime date) {
  //   // TODO: implement fetchTracksByDate
  //   throw UnimplementedError();
  // }

}

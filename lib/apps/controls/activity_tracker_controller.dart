// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/constrains.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../services/auth_service.dart';
import '../../services/data_service.dart';
import '../data/models/Meal.dart';
import '../data/models/nutrition.dart';
import '../data/models/water.dart';

class ActivityTrackerC extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;
  final Rx<List<Map<String, dynamic>>> _listSleepData =
      Rx<List<Map<String, dynamic>>>([]);
  List<Map<String, dynamic>> get listSleepData => _listSleepData.value;
  RxInt chartIndex = 0.obs;
  // {
  //   'bedTime': DateTime(),
  //   'alarm': DateTime(),
  //   'goal': int
  // }

  @override
  void onInit() async {
    // print(_user.value['name']);
    super.onInit();
    await DataService.instance.loadMealList();
    getStartDateAndFinishDate();
    dateWaterController = dateSleepController;
    allDateWater.value = allDateSleep.value;
    startDateWater.value = startDateSleep.value;
    finishDateWater.value = finishDateSleep.value;

    dateNutriController = dateSleepController;
    allDateNutri.value = allDateSleep.value;
    startDateNutri.value = startDateSleep.value;
    finishDateNutri.value = finishDateSleep.value;

    allDateWeight.value = allDateSleep.value;

    getDataSleepChart();
    getDataWaterChart();
    getDataNutriChart();
    getDataWeight();
    update();
  }

  @override
  // ignore: unnecessary_overrides
  void onClose() {
    super.onClose();
  }

  //-----get date -----------------------------
  //weight ------------------------------------
  DateTime selectDateTempWeight1 = DateTime.now();
  DateTime selectDateTempWeight2 = DateTime.now();

  Rx<DateTime> startDateWeight = DateTime.now().obs;
  Rx<DateTime> finishDateWeight = DateTime.now().obs;

  DateRangePickerController dateWeightController = DateRangePickerController();
  RxList<DateTime> allDateWeight = <DateTime>[].obs;

  final Rx<List<int>> _listWeightData = Rx<List<int>>([]);
  List<int> get listWeightData => _listWeightData.value;
  void onSectionDate(DateRangePickerSelectionChangedArgs args) {
    PickerDateRange ranges = args.value;
    DateTime date1 = ranges.startDate!;
    DateTime date2 = (ranges.endDate ?? ranges.startDate)!;
    if (date1.isAfter(date2)) {
      var date = date1;
      date1 = date2;
      date2 = date;
    }
    dateWeightController.selectedRange = PickerDateRange(date1, date2);
    if (date1 != null && date2 != null) {
      allDateWeight.value =
          List<DateTime>.generate(getDayInBetWeen(date2, date1) + 1, (index) {
        DateTime date = date1;
        return date.add(Duration(days: index));
      });
    }
  }

  int get maxOfList => [for (var item in listWeightData) item].reduce(max);

  getDataWeight() async {
    _listWeightData.bindStream(firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('weight')
        .snapshots()
        .map((event) {
      List<int> result = [for (var item in allDateWeight.value) 0];
      for (var item in event.docs) {
        DateTime date = DateTime.fromMillisecondsSinceEpoch(
            item.data()['date'].seconds * 1000);
        DateTime timeCheck = DateTime(date.year, date.month, date.day, 0, 0, 0);
        if (allDateWeight.value.contains(timeCheck)) {
          result[allDateWeight.value.indexOf(timeCheck)] = item.data()['data'];
        }
      }
      return result;
    }));
    update();
  }

  //Sleep---------------------
  DateTime selectDateTempSleep1 = DateTime.now();
  DateTime selectDateTempSleep2 = DateTime.now();

  Rx<DateTime> startDateSleep = DateTime.now().obs;
  Rx<DateTime> finishDateSleep = DateTime.now().obs;

  RxList<DateTime> allDateSleep = <DateTime>[].obs;
  DateRangePickerController dateSleepController = DateRangePickerController();
  bool checkDateInList(DateTime date, List<DateTime> allDateBetWeen) {
    for (var item in allDateBetWeen) {
      if (date.day == item.day &&
          date.month == item.month &&
          date.year == item.year) return true;
    }
    return false;
  }

  bool checkListSleepDate(
      DateTime date, List<Map<String, dynamic>> allDateBetWeen) {
    for (var item in allDateBetWeen) {
      if (date.day == item['bedTime'].day &&
          date.month == item['bedTime'].month &&
          date.year == item['bedTime'].year) return true;
    }
    return false;
  }

  getDataSleepChart() async {
    _listSleepData.bindStream(
      firestore
          .collection('users')
          .doc(AuthService.instance.currentUser!.uid)
          .collection('sleep_basic_time')
          .doc('sleep')
          .collection('sleep_report')
          .snapshots()
          .map((event) {
        List<Map<String, dynamic>> result = [
          for (var item in allDateSleep.value)
            {
              'id': item.weekday,
              'bedTime': item,
              'alarm': item,
              'goal': 0,
            }
        ];
        // 1 2 3 4 5 6 7
        result.sort((a, b) => a['id'].compareTo(b['id']));
        DateTime getDateSunday =
            result[5]['bedTime'].add(const Duration(days: 1));
        result[6]['bedTime'] = getDateSunday;
        result[6]['alarm'] = getDateSunday;
        List<Map<String, dynamic>> resultTemp = result;
        for (var item in event.docs) {
          Map<String, dynamic> data = item.data();
          DateTime date =
              DateTime.fromMillisecondsSinceEpoch(data['alarm'].seconds * 1000);
          if (checkListSleepDate(date, resultTemp)) {
            // result[date.weekday - 1]['data'] += data['goal'];
            if (data['goal'] > result[date.weekday - 1]['goal']) {
              result[date.weekday - 1]['goal'] = data['goal'];
              result[date.weekday - 1]['alarm'] = date;
              result[date.weekday - 1]['bedTime'] =
                  DateTime.fromMillisecondsSinceEpoch(
                      data['bedTime'].seconds * 1000);
            }
          }
        }
        return result;
      }),
    );
    update();
  }
  //Water---------------------

  DateTime selectDateTempWater1 = DateTime.now();
  DateTime selectDateTempWater2 = DateTime.now();

  Rx<DateTime> startDateWater = DateTime.now().obs;
  Rx<DateTime> finishDateWater = DateTime.now().obs;

  RxList<DateTime> allDateWater = <DateTime>[].obs;
  DateRangePickerController dateWaterController = DateRangePickerController();
  final Rx<List<Map<String, dynamic>>> _listWaterData =
      Rx<List<Map<String, dynamic>>>([]);
  List<Map<String, dynamic>> get listWaterData => _listWaterData.value;

  int get waterConsumeWeek => listWaterData.fold<int>(0, (sum, e) {
        return sum + e['consume'] as int;
      });
  getDataWaterChart() async {
    _listWaterData.bindStream(
      firestore
          .collection('users')
          .doc(AuthService.instance.currentUser!.uid)
          .collection('water')
          .snapshots()
          .map(
        (event) {
          List<Map<String, dynamic>> result = [
            for (var item in allDateWater.value)
              {
                'id': item.weekday,
                'consume': 0,
                'target': 4000,
              }
          ];
          result.sort((a, b) => a['id'].compareTo(b['id']));
          for (var item in event.docs) {
            Water data = Water.fromSnap(item);
            if (checkDateInList(data.date, allDateWater.value)) {
              result[data.date.weekday - 1]['target'] = data.target;
              result[data.date.weekday - 1]['consume'] =
                  data.waterConsume.fold<int>(0, (sum, e) {
                return sum + e['consume'] as int;
              });
            }
          }
          return result;
        },
      ),
    );
    update();
  }

  int get maxList => [
        for (var item in listWaterData)
          max(item['consume'] as int, item['target'] as int)
      ].reduce(max);

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        toY: y1,
        color: Colors.blue.withOpacity(0.7),
        width: 7,
      ),
      BarChartRodData(
        toY: y2,
        color: Colors.red.withOpacity(0.7),
        width: 7,
      ),
    ]);
  }

  //Nutrition-------------------------------------
  DateTime selectDateTempNutri1 = DateTime.now();
  DateTime selectDateTempNutri2 = DateTime.now();

  Rx<DateTime> startDateNutri = DateTime.now().obs;
  Rx<DateTime> finishDateNutri = DateTime.now().obs;

  RxList<DateTime> allDateNutri = <DateTime>[].obs;
  DateRangePickerController dateNutriController = DateRangePickerController();
  final Rx<List<Map<String, dynamic>>> _listNutriData =
      Rx<List<Map<String, dynamic>>>([]);
  List<Map<String, dynamic>> get listNutriData => _listNutriData.value;
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

  getDataNutriChart() async {
    _listNutriData.bindStream(firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('Nutrition')
        .snapshots()
        .map((event) {
      List<Map<String, dynamic>> result = [
        for (var item in allDateNutri.value)
          {
            'id': item.weekday,
            'kCal': 0,
          }
      ];
      result.sort((a, b) => a['id'].compareTo(b['id']));
      print(DataService.instance.mealList);
      for (var item in event.docs) {
        Nutrition data = Nutrition.fromSnap(item);
        if (checkDateInList(data.dateTime, allDateNutri.value)) {
          result[data.dateTime.weekday - 1]['kCal'] += data.amount *
              getMealId(data.id, DataService.instance.mealList).kCal;
        }
      }
      return result;
    }));
    update();
  }

  List<Map<String, dynamic>> get listDataNutriPlan =>
      DataService.instance.dataNutriPlan;

  // Function for select date time ---------------------
  selectDateDoneClick() {
    if (chartIndex.value == 0) {
      startDateSleep.value = selectDateTempSleep1;
      finishDateSleep.value = selectDateTempSleep2;
      allDateSleep.value = getListDateBetWeenRange();
      getDataSleepChart();
    } else if (chartIndex.value == 4) {
      startDateWater.value = selectDateTempWater1;
      finishDateWater.value = selectDateTempWater2;
      allDateWater.value = getListDateBetWeenRange();
      getDataWaterChart();
    } else if (chartIndex.value == 3) {
      startDateNutri.value = selectDateTempNutri1;
      finishDateNutri.value = selectDateTempNutri2;
      allDateNutri.value = getListDateBetWeenRange();
      getDataNutriChart();
    }
    update();
  }

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
      switch (chartIndex.value) {
        case 0:
          dateSleepController.selectedRange = PickerDateRange(dat1, dat2);
          selectDateTempSleep1 = dat1;
          selectDateTempSleep2 = dat2;
          break;
        case 3:
          dateNutriController.selectedRange = PickerDateRange(dat1, dat2);
          selectDateTempNutri1 = dat1;
          selectDateTempNutri2 = dat2;
          break;
        case 4:
          dateWaterController.selectedRange = PickerDateRange(dat1, dat2);
          selectDateTempWater1 = dat1;
          selectDateTempWater2 = dat2;
          break;
        default:
          break;
      }
    }
  }

  getDayInBetWeen(DateTime f, DateTime s) {
    int difference = f.difference(s).inDays;
    return difference;
  }

  //get list date to load chart
  List<DateTime> getListDateBetWeenRange() {
    List<DateTime> items = [];
    switch (chartIndex.value) {
      case 0:
        items = List<DateTime>.generate(
            getDayInBetWeen(finishDateSleep.value, startDateSleep.value) + 1,
            (index) {
          DateTime date = startDateSleep.value;
          return date.add(Duration(days: index));
        });
        break;
      case 3:
        items = List<DateTime>.generate(
            getDayInBetWeen(finishDateNutri.value, startDateNutri.value) + 1,
            (index) {
          DateTime date = startDateNutri.value;
          return date.add(Duration(days: index));
        });
        break;

      case 4:
        items = List<DateTime>.generate(
            getDayInBetWeen(finishDateWater.value, startDateWater.value) + 1,
            (index) {
          DateTime date = startDateWater.value;
          return date.add(Duration(days: index));
        });
        break;
      default:
        break;
    }

    return items;
  }

  //get date start and date finish to load chart
  void getStartDateAndFinishDate() {
    DateTime now = DateTime.now();
    int weekDay = now.weekday == 7 ? 0 : now.weekday;
    if (chartIndex.value == 0) {
      startDateSleep.value = DateTime.now();
      finishDateSleep.value = DateTime.now();
    }
    for (int i = 0; i < weekDay; i++) {
      if (chartIndex.value == 0) {
        startDateSleep.value =
            startDateSleep.value.add(const Duration(days: -1));
      }
    }
    for (int i = 0; i < 6 - weekDay; i++) {
      if (chartIndex.value == 0) {
        finishDateSleep.value =
            finishDateSleep.value.add(const Duration(days: 1));
      }
    }
    if (chartIndex.value == 0) {
      allDateSleep.value = List<DateTime>.generate(
          7, (index) => startDateSleep.value.add(Duration(days: index)));
    }
    update();
  }

  //-------------------------------------------

  Future<Map<String, dynamic>> getDataUser(String uid) async {
    var userDoc = await firestore.collection('users').doc(uid).get();
    Map<String, dynamic> result = (userDoc.data() as Map<String, dynamic>);
    return result;
  }

  getUser() async {
    //ignore: avoid_print
    print(firebaseAuth.currentUser!.uid);

    _user.value = await getDataUser(firebaseAuth.currentUser!.uid);
    update();
  }
}

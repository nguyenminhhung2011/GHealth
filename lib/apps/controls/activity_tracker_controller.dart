// ignore_for_file: unnecessary_null_comparison

import 'package:get/get.dart';
import 'package:gold_health/constrains.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../services/auth_service.dart';

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
  void onInit() {
    // print(_user.value['name']);
    super.onInit();
    getStartDateAndFinishDate();
    getDataSleepChart();
    update();
  }

  @override
  // ignore: unnecessary_overrides
  void onClose() {
    super.onClose();
  }

  //-----get date -----------------------------
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

  selectDateDoneClick() {
    if (chartIndex.value == 0) {
      startDateSleep.value = selectDateTempSleep1;
      finishDateSleep.value = selectDateTempSleep2;
      allDateSleep.value = getListDateBetWeenRange();
      getDataSleepChart();
    }
    update();
  }

  //Water-------------------------------------
  // Function for select date time ---------------------
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
        default:
          break;
      }
    }
  }

  getDayInBetWeen() {
    int difference = 0;
    switch (chartIndex.value) {
      case 0:
        difference =
            finishDateSleep.value.difference(startDateSleep.value).inDays;
        break;
      default:
        break;
    }
    return difference;
  }

  //get list date to load chart
  List<DateTime> getListDateBetWeenRange() {
    List<DateTime> items = [];
    switch (chartIndex.value) {
      case 0:
        items = List<DateTime>.generate(getDayInBetWeen() + 1, (index) {
          DateTime date = startDateSleep.value;
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

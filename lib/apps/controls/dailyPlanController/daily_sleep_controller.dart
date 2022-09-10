// ignore_for_file: unnecessary_null_comparison

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/tracker_controller.dart';
import 'package:gold_health/apps/template/misc/untils.dart';
import 'package:gold_health/services/notification.dart';
import 'package:intl/intl.dart';
import 'package:progressive_time_picker/progressive_time_picker.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../constrains.dart';
import '../../../services/auth_service.dart';
import '../../../services/data_service.dart';
import '../../data/models/sleep.dart';
import '../../pages/sleep_tracker/widgets/updateDeleteItemDialog.dart';
import '../../template/misc/colors.dart';

class DailySleepController extends GetxController with TrackerController {
  RxList<Map<String, dynamic>> stepWeek = <Map<String, dynamic>>[].obs;
  Map<String, dynamic> get sleepBasictime =>
      DataService.instance.sleepBasicTIme;
  List<Sleep> get listSleep => DataService.instance.listSleepTime;

  @override
  void onInit() {
    super.onInit();
    _calendarController.value = CalendarController();
    getStartDateAndFinishDate();
    getDataChart();
    update();
  }

  //------------------------------------
  List<Sleep> get listSleepToday => [
        for (var item in DataService.instance.listSleepTime)
          if (item.listDate.contains(DateTime.now().weekday)) item
      ];
  List<Sleep> listSleepWithDate(int date) => [
        for (var item in DataService.instance.listSleepTime)
          if (item.listDate.contains(date)) item
      ];
  List<Map<String, dynamic>> get listSleepReport =>
      DataService.instance.listSleepReport;
  List<Map<String, dynamic>> listSleepReportDate(DateTime date) => [
        for (var item in DataService.instance.listSleepReport)
          if (item['bedTime'].year == date.year &&
              item['bedTime'].month == date.month &&
              item['bedTime'].day == date.day &&
              item['goal'] != -1)
            item
      ];

  final Rx<int> _onFocus = 1.obs;
  final Rx<CalendarController> _calendarController = CalendarController().obs;

  CalendarController get calendarController => _calendarController.value;
  final List<DateTime> listDateTime = [
    for (int i = 1; i <= 30; i++) DateTime.now().subtract(Duration(days: i)),
    for (int i = 0; i <= 30; i++) DateTime.now().add(Duration(days: i))
  ];
  setFocus(int index, DateTime time) {
    _onFocus.value = index;
    _calendarController.value.displayDate = time;
    update();
  }

  //------------------------sleep counting

  //------------------------------------add alarm

  var now = DateTime.now();
  Rx<DateTime> choseTime = DateTime.now().obs;
  DateTime tempTime = DateTime.now();

  Rx<Duration> choseDuration = const Duration(hours: 8).obs;
  Duration tempDuration = const Duration();
  var isVibrate = true.obs;
  DateRangePickerController dateController = DateRangePickerController();

  Map<String, dynamic> listVariable = {
    'Sun': false.obs,
    'Mon': false.obs,
    'Tue': false.obs,
    'Wed': false.obs,
    'Thu': false.obs,
    'Fri': false.obs,
    'Sat': false.obs,
  };

  Map<String, dynamic> weekDayTonInt = {
    'Sun': 7,
    'Mon': 1,
    'Tue': 2,
    'Wed': 3,
    'Thu': 4,
    'Fri': 5,
    'Sat': 6,
  };

  PickedTime inBedTime = PickedTime(h: 0, m: 0);
  PickedTime outBedTime = PickedTime(h: 8, m: 0);
  PickedTime intervalBedTime = PickedTime(h: 0, m: 0);
  Rx<String> idSleepReport = ''.obs;

  void disposePickTime() {
    inBedTime = PickedTime(h: 0, m: 0);
    outBedTime = PickedTime(h: 8, m: 0);
    intervalBedTime = PickedTime(h: 0, m: 0);
    idSleepReport.value = '';
  }

  List ntToWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  initAll() {
    choseTime = DateTime.now().obs;
    tempTime = DateTime.now();

    choseDuration = const Duration(hours: 8).obs;
    tempDuration = const Duration();
    isVibrate = true.obs;
    listVariable = {
      'Sun': false.obs,
      'Mon': false.obs,
      'Tue': false.obs,
      'Wed': false.obs,
      'Thu': false.obs,
      'Fri': false.obs,
      'Sat': false.obs,
    };
    update();
  }

  saveAlarmFirebase() async {
    List<int> dateSelect = [];
    listVariable.forEach((key, value) {
      if ((value as RxBool).value) {
        dateSelect.add(weekDayTonInt[key]);
      }
    });
    Duration temp = choseDuration.value;
    dateSelect = dateSelect.isNotEmpty ? dateSelect : [1, 2, 3, 4, 5, 6, 7];
    // DateTime alarm = (choseTime.value).add((choseDuration.value));
    DateTime bedTime = choseTime.value;
    DateTime alarm = bedTime.add(temp);
    await firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('sleep_basic_time')
        .doc('sleep')
        .collection('sleep_time')
        .add({
      'id': 'sleep ${DataService.instance.listSleepTime.length}',
      'alarm': alarm,
      'bedTime': choseTime.value,
      'isTurnOn': isVibrate.value,
      'isTurnOn1': isVibrate.value,
      'listDate': dateSelect,
    });
    print(alarm);
    print(bedTime);
    // createSleepNotificationAuto(
    //   NotificationWeekAndTime(
    //     dayOfTheWeek: 6,
    //     timeOfDay: TimeOfDay(
    //         hour: DateTime.now().hour, minute: DateTime.now().minute + 1),
    //   ),
    // );
    for (var item in dateSelect) {
      createSleepNotificationAuto(
        NotificationWeekAndTime(
          dayOfTheWeek: item,
          timeOfDay: TimeOfDay(hour: bedTime.hour, minute: bedTime.minute),
        ),
      );
      int wdAlarm = ((bedTime.weekday - alarm.weekday) > 0) ? 1 : 0;
      createAlarmNotificationAuto(
        NotificationWeekAndTime(
          dayOfTheWeek: (item == 7)
              ? (wdAlarm == 1)
                  ? 1
                  : item
              : item + wdAlarm,
          timeOfDay: TimeOfDay(hour: alarm.hour, minute: alarm.minute),
        ),
      );
    }
  }

  updateDataCollection(Map<String, dynamic> data) async {
    try {
      await firestore
          .collection('users')
          .doc(AuthService.instance.currentUser!.uid)
          .collection('sleep_basic_time')
          .doc('sleep')
          .collection('sleep_time')
          .doc(data['id'])
          .update(data);
    } catch (err) {
      // ignore: avoid_print
      print(err);
    }
  }

  Future<String> updateGoalSleepReport(int newGoal) async {
    try {
      await firestore
          .collection('users')
          .doc(AuthService.instance.currentUser!.uid)
          .collection('sleep_basic_time')
          .doc('sleep')
          .collection('sleep_report')
          .doc(idSleepReport.value)
          .update(
        {
          'goal': newGoal,
        },
      );
      return 'Success';
    } catch (err) {
      return err.toString();
    }
  }

  deleteDataCollection(String id) async {
    try {
      await firestore
          .collection('users')
          .doc(AuthService.instance.currentUser!.uid)
          .collection('sleep_basic_time')
          .doc('sleep')
          .collection('sleep_time')
          .doc(id)
          .delete();
    } catch (err) {
      // ignore: avoid_print
      print(err);
    }
  }

  Future<String> addNewSleepReportToFirebase() async {
    try {
      DateTime bedTime =
          DateTime(now.year, now.month, now.day, inBedTime.h, inBedTime.m, 0);
      DateTime alarm = bedTime
          .add(Duration(minutes: intervalBedTime.h * 60 + intervalBedTime.m));
      DocumentReference docRef = await firestore
          .collection('users')
          .doc(AuthService.instance.currentUser!.uid)
          .collection('sleep_basic_time')
          .doc('sleep')
          .collection('sleep_report')
          .add(
        {
          'bedTime': bedTime,
          'alarm': alarm,
          'goal': -1,
        },
      );
      idSleepReport.value = docRef.id;
      return 'Success';
    } catch (err) {
      return err.toString();
    }
  }

  // ---------------------------loading chart data--------------------------
  DateTime selectDateTemp1 = DateTime.now();
  DateTime selectDateTemp2 = DateTime.now();

  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> finishDate = DateTime.now().obs;

  RxList<DateTime> allDateBetWeen = <DateTime>[].obs;
  final Rx<List<Map<String, dynamic>>> _dataChart =
      Rx<List<Map<String, dynamic>>>([]);
  List<Map<String, dynamic>> get dataChart => _dataChart.value;

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

  //load data chart with select calendar
  selectDateDoneClick() {
    startDate.value = selectDateTemp1;
    finishDate.value = selectDateTemp2;
    allDateBetWeen.value = getListDateBetWeenRange();
    getDataChart();
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

  bool checkDateInList(DateTime date) {
    for (var item in allDateBetWeen.value) {
      if (date.day == item.day &&
          date.month == item.month &&
          date.year == item.year) return true;
    }
    return false;
  }

  int get maxList => [
        for (var item in dataChart) (item['data'] as int),
      ].reduce(max);

  getDataChart() async {
    _dataChart.bindStream(firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('sleep_basic_time')
        .doc('sleep')
        .collection('sleep_report')
        .snapshots()
        .map((event) {
      List<Map<String, dynamic>> result = [
        for (var item in allDateBetWeen.value)
          {
            'id': item.weekday,
            'data': 0,
          }
      ];
      result.sort((a, b) => a['id'].compareTo(b['id']));
      for (var item in event.docs) {
        Map<String, dynamic> data = item.data();
        DateTime date =
            DateTime.fromMillisecondsSinceEpoch(data['bedTime'].seconds * 1000);
        if (checkDateInList(date)) {
          result[date.weekday - 1]['data'] += data['goal'];
        }
      }
      return result;
    }));
  }

  //------------------------------------Widget Item Builder--------------------------------

  int get onFocus => _onFocus.value;
  Widget itemBuilder(Sleep element, double widthDevice, BuildContext context) {
    DateTime timeBed = element.bedTime;
    DateTime timeAlarm = element.alarm;
    int hourBed = (DateTime.now().hour - timeBed.hour).abs();
    int minuteBed = (DateTime.now().minute - timeBed.minute).abs();
    int hourAlarm = (DateTime.now().hour - timeAlarm.hour).abs();
    int minuteAlarm = (DateTime.now().hour - timeAlarm.hour).abs();
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      width: widthDevice * 0.9,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 248, 251),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              child: Row(
                children: [
                  Image.asset('assets/images/duration.png',
                      height: 20, width: 20),
                  const SizedBox(width: 10),
                  const Text(
                    'Schedule',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () async {
                      await showDialog(
                        useRootNavigator: false,
                        barrierColor: Colors.black54,
                        context: context,
                        builder: (context) {
                          // initAll1(element);
                          return DialogUpdateDelete(
                            element: element,
                          );
                        },
                      );
                    },
                    child: const Icon(
                      Icons.more_horiz,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          ...[0, 1, 2]
              .map(
                (i) => (i == 1)
                    ? const Divider()
                    : ListTile(
                        isThreeLine: true,
                        leading: Image.asset(i == 0
                            ? 'assets/images/bed.png'
                            : 'assets/images/Icon-Alaarm.png'),
                        title: RichText(
                          text: TextSpan(
                            text: '${i == 0 ? 'BedTime' : 'Alarm'}, ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Sen',
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                  text:
                                      "${DateFormat().add_jm().format(i == 0 ? timeBed : timeAlarm)} ",
                                  style: const TextStyle(
                                      fontFamily: 'Sen',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54)),
                            ],
                          ),
                        ),
                        subtitle: Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: RichText(
                            text: TextSpan(
                              text: 'in ',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                              children: [
                                TextSpan(
                                  text: '${i == 0 ? hourBed : hourAlarm}',
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[600]),
                                ),
                                TextSpan(
                                  text: 'hours ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                TextSpan(
                                  text: '${i == 0 ? minuteBed : minuteAlarm}',
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[600]),
                                ),
                                TextSpan(
                                  text: 'minutes',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                              child: CupertinoSwitch(
                                activeColor: AppColors.primaryColor1,
                                value: (i == 0)
                                    ? element.isTurnOn
                                    : element.isTurnOn1,
                                onChanged: (bool value) {
                                  updateDataCollection({
                                    'id': element.id,
                                    'bedTime': element.bedTime,
                                    'alarm': element.alarm,
                                    'isTurnOn': (i == 0)
                                        ? !element.isTurnOn
                                        : element.isTurnOn,
                                    'isTurnOn1': (i == 2)
                                        ? !element.isTurnOn1
                                        : element.isTurnOn1,
                                    'listDate': element.listDate,
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
              )
              .toList()
        ],
      ),
    );
  }
}

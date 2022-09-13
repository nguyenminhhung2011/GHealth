import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/tracker_controller.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../services/auth_service.dart';
import '../../data/models/workout_model.dart';
import '../../../constrains.dart';

class WorkoutPlanController extends GetxController with TrackerController {
  TextEditingController text = TextEditingController();
  Map<String, Uint8List> listThumbnail = {};
  DateRangePickerController dateController = DateRangePickerController();
  var alarmTime = DateTime.now().obs;
  var level = 'Beginner'.obs;
  late Rx<DateTimeRange> dateTimeRange;
  late Rx<List<DateTime>> allDateBetWeen;

  /////////////////////////////////////

  /////////////////////////////////////
  var exercises = Rx<Map<String, Exercise>>({});
  var workouts = Rx<Map<String, Map<String, dynamic>>>({});
  var schedules = Rx<Map<String, WorkoutSchedule>>({});
  var histories = Rx<Map<String, WorkoutHistory>>({});

  Map<String, Exercise> get exerciseList {
    return exercises.value;
  }

  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
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

  DateTime selectDateTemp1 = DateTime.now();
  DateTime selectDateTemp2 = DateTime.now();

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
    dateTimeRange.value =
        DateTimeRange(start: selectDateTemp1, end: selectDateTemp2);
    allDateBetWeen.value = getListDateBetWeenRange();
    // getDataChart(0);
    update();
  }

  // get number date between

  //get list date to load chart
  List<DateTime> getListDateBetWeenRange() {
    final items =
        List<DateTime>.generate(dateTimeRange.value.duration.inDays, (index) {
      DateTime date = dateTimeRange.value.start;
      return date.add(Duration(days: index));
    });
    return items;
  }

  ///////Data Structure
  // {
  //     'idWorkout': {
  //       'collection': {
  //         'Beginner': {'Workout'},
  //         'Intermediate': {'Workout'},
  //         'Advance': {'Workout'},
  //       },
  //       'workoutCategory': 'fullbody',
  //     }
  //   },

  @override
  void onInit() async {
    await fetchAllDataAboutWorkout();
    dateTimeRange = DateTimeRange(
            start: findFirstDateOfTheWeek(DateTime.now()),
            end: findLastDateOfTheWeek(DateTime.now()))
        .obs;
    await Future.value(allDateBetWeen.value = getListDateBetWeenRange());
    super.onInit();
  }

  final Map<String, String> listImage = {
    'Fullbody': 'assets/images/fullbody.png',
    'Upperbody': 'assets/images/upperbody.png',
    'Abs': 'assets/images/abs.png',
    'Lowebody': 'assets/images/lowebody.png',
    'Cardio': 'assets/images/cardio.png',
    'Hitt': 'assets/images/hitt.png',
  };

  Future<bool> fetchWorkoutList() async {
    try {
      await Future(() {
        workouts.bindStream(
          firestore.collection('workout').snapshots().map(
            (event) {
              Map<String, Map<String, dynamic>> result = {};
              for (var doc in event.docs) {
                String idWorkout = doc.id;
                String workoutCategory = doc.data()['workoutCategory'];
                Map<String, dynamic> listLevel = {};
                for (String level in ['Beginner', 'Intermediate', 'Advanced']) {
                  Map<String, dynamic> listWorkoutInLevel = {};
                  firestore
                      .collection('workout')
                      .doc(idWorkout)
                      .collection(level)
                      .snapshots()
                      .forEach((docOfCollectionWorkout) {
                    for (var docWorkout in docOfCollectionWorkout.docs) {
                      listWorkoutInLevel.putIfAbsent(docWorkout.id,
                          () => Workout.fromSnap(docWorkout, workoutCategory));
                    }
                  });
                  listLevel.putIfAbsent(level, () => listWorkoutInLevel);
                }
                result.putIfAbsent(
                  idWorkout,
                  () => {
                    'workoutCategory': workoutCategory,
                    'collection': listLevel,
                  },
                );
              }
              return result;
            },
          ),
        );
      });
      debugPrint('workouts: ${workouts.value.length}');
      debugPrint(workouts.toString());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> fetchExerciseList() async {
    String? id;
    try {
      await Future(
        () {
          exercises.bindStream(
            firestore.collection('exercise').snapshots().map(
              (event) {
                Map<String, Exercise> result = {};
                for (var doc in event.docs) {
                  id = doc.id;
                  result.putIfAbsent(doc.id, () => Exercise.fromSnap(doc));
                }
                return result;
              },
            ),
          );
        },
      );
      debugPrint('exercises: ${exercises.value.length.toString()}');
      debugPrint(exercises.value.toString());
      return true;
    } catch (e) {
      print('fetchExerciseList ------ ${e.toString()}');
      print('Exercise id:$id');
      return false;
    }
  }

  Future<bool> fetchScheduleList() async {
    try {
      await Future(
        () {
          String userId = AuthService.instance.currentUser!.uid;
          schedules.bindStream(
            firestore
                .collection('users')
                .doc(userId)
                .collection('workout_schedule')
                .snapshots()
                .map(
              (event) {
                Map<String, WorkoutSchedule> result = {};
                for (var docInWorkoutSchedule in event.docs) {
                  result.addAll(
                    {
                      docInWorkoutSchedule.id:
                          WorkoutSchedule.fromSnap(docInWorkoutSchedule)
                    },
                  );
                }
                return result;
              },
            ),
          );
        },
      );

      debugPrint('schedules: ${schedules.value.length.toString()}');
      debugPrint(schedules.value.toString());
      return true;
    } catch (e) {
      debugPrint('fetchScheduleList: $e');
      return false;
    }
  }

  Future<bool> fetchHistoryList() async {
    try {
      await Future(
        () {
          String userId = AuthService.instance.currentUser!.uid;
          histories.bindStream(
            firestore
                .collection('users')
                .doc(userId)
                .collection('workout_history')
                .snapshots()
                .map(
              (event) {
                Map<String, WorkoutHistory> result = {};
                for (var doc in event.docs) {
                  result.addAll({doc.id: WorkoutHistory.fromSnap(doc)});
                }
                return result;
              },
            ),
          );
        },
      );
      debugPrint('histories: ${histories.value.length.toString()}');
      debugPrint(histories.value.toString());
      return true;
    } catch (e) {
      print('fetchHistoryList: $e');
      return false;
    }
  }

  Future fetchAllDataAboutWorkout() async {
    await fetchExerciseList();
    await fetchWorkoutList();
    await fetchScheduleList();
    await fetchHistoryList();
  }

  String getCaloriesBurnFromWorkout(List<String> listExercise) {
    int result = 0;
    for (var element in listExercise) {
      result += exercises.value[element]!.caloriesBurn;
    }
    return result.toString();
  }

  String getDurationFromWorkout(List<String> listExercise) {
    int result = 0;
    for (var element in listExercise) {
      result += exercises.value[element]!.duration.inSeconds;
    }
    return result.toString();
  }

  Future<String> addWorkoutSchedule(Map<String, dynamic> data) async {
    final response = await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('workout_schedule')
        .add(data);
    print('schedules.value.length: ${schedules.value.length}');

    return response.id;
  }

  Future addWorkoutHistory(Map<String, dynamic> data) async {
    await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('workout_history')
        .add(data);
  }

  Future<void> updateScheduleWorkout(
      String id, WorkoutSchedule newSchedule) async {
    await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('workout_schedule')
        .doc(id)
        .update(
      {
        'duration': newSchedule.duration.toString(),
        'isFinish': newSchedule.isFinish,
        'isTurnOn': newSchedule.isTurnOn,
        'level': newSchedule.level,
        'time': Timestamp.fromDate(newSchedule.time),
        'weight': newSchedule.weight.toString(),
        'workoutCategory': newSchedule.workoutCategory,
      },
    );
  }

  Future<bool> deleteScheduleWorkout(String scheduleId) async {
    try {
      await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('workout_schedule')
          .doc(scheduleId)
          .delete();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}

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
  /////////////////////////////////////

  /////////////////////////////////////
  var exercises = Rx<Map<String, Exercise>>({});
  var workouts = Rx<Map<String, Map<String, dynamic>>>({});
  var schedules = Rx<Map<String, WorkoutSchedule>>({});
  var histories = Rx<Map<String, WorkoutHistory>>({});
  var flSpotChart = Rx<Map<DateTime, double>>({});
  ////////////////////////////////////////////////

  Map<String, Exercise> get exerciseList {
    return exercises.value;
  }

  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday % 7));
  }

  DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime.add(Duration(days: 6 - dateTime.weekday % 7));
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    PickerDateRange ranges = args.value;
    DateTime startDate = findFirstDateOfTheWeek(ranges.startDate!);
    DateTime lastDate = findLastDateOfTheWeek(ranges.startDate!);
    dateController.selectedRange = PickerDateRange(startDate, lastDate);
  }

  //load data chart with select calendar
  selectDateDoneClick() {
    dateTimeRange.value = DateTimeRange(
        start: dateController.selectedRange!.startDate!,
        end: dateController.selectedRange!.startDate!);
  }

  //get list date to load chart
  List<DateTime> getListDateBetWeenRange() {
    final items =
        List<DateTime>.generate(dateTimeRange.value.duration.inDays, (index) {
      DateTime date = dateTimeRange.value.start;
      return date.add(Duration(days: index));
    });
    return items;
  }

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
    dateTimeRange = DateTimeRange(
            start: findFirstDateOfTheWeek(DateTime.now()),
            end: findLastDateOfTheWeek(DateTime.now()))
        .obs;

    dateController.selectedRange = PickerDateRange(
        findFirstDateOfTheWeek(DateTime.now()),
        findLastDateOfTheWeek(DateTime.now()));
    dateTimeRange.listen((p0) async {
      await fetchWorkoutHistoryDataWithDateRange(p0);
    });
    await fetchAllDataAboutWorkout();

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
                  result.addAll(
                    {
                      doc.id: WorkoutHistory.fromSnap(doc),
                    },
                  );
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

  Future<void> fetchWorkoutHistoryDataWithDateRange(DateTimeRange range) async {
    print(range.start);
    flSpotChart.bindStream(histories.stream.map((event) {
      Map<DateTime, double> result = {};
      event.forEach((key, value) {
        print(value.time);
        if ((value.time.isAfter(range.start) ||
                (value.time.day == range.start.day &&
                    value.time.month == range.start.month &&
                    value.time.year == range.start.year)) &&
            (value.time.isBefore(range.end) ||
                (value.time.day == range.end.day &&
                    value.time.month == range.end.month &&
                    value.time.year == range.end.year))) {
          print('capture');

          result[DateTime(value.time.year, value.time.month, value.time.day)] =
              result[DateTime(
                      value.time.year, value.time.month, value.time.day)] ??
                  0.0 + value.caloriesBurn;
        }
      });
      return result;
    }));
  }

  Future fetchAllDataAboutWorkout() async {
    await fetchExerciseList();
    await fetchWorkoutList();
    await fetchScheduleList();
    await fetchHistoryList();
    await fetchWorkoutHistoryDataWithDateRange(dateTimeRange.value);
    print('flSpotChart: ${flSpotChart.value}');
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

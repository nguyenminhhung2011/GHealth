import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/tracker_controller.dart';

import '../../../services/auth_service.dart';
import '../../data/models/workout_model.dart';

class WorkoutPlanController extends GetxController with TrackerController {
  TextEditingController text = TextEditingController();
  Map<String, Uint8List> listThumbnail = {};
  var alarmTime = DateTime.now().obs;
  var level = 'Beginner'.obs;

  var exercises = Rx<Map<String, Exercise>>({});
  var workouts = Rx<Map<String, Map<String, dynamic>>>({});
  var schedules = Rx<Map<String, WorkoutSchedule>>({});
  var histories = Rx<Map<String, WorkoutHistory>>({});

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

  final Map<String, String> listImage = {
    'Fullbody': 'assets/images/fullbody.png',
    'Upperbody': 'assets/images/upperbody.png',
    'Abs': 'assets/images/abs.png',
    'Lowebody': 'assets/images/lowebody.png',
    'Cardio': 'assets/images/cardio.png',
    'Hitt': 'assets/images/hitt.png',
  };

  Future<bool> fetchWorkoutList() async {
    String temp = ' ';
    try {
      CollectionReference<Map<String, dynamic>> listWorkout =
          FirebaseFirestore.instance.collection('workout');
      final data = await listWorkout.get();
      print(data.size);
      for (var doc in data.docs) {
        String idWorkout = doc.id;
        String workoutCategory = doc.data()['workoutCategory'];
        Map<String, dynamic> listLevel = {};

        for (String level in ['Beginner', 'Intermediate', 'Advanced']) {
          final docOfCollectionWorkout =
              await listWorkout.doc(idWorkout).collection(level).get();

          Map<String, dynamic> listWorkoutInLevel = {};
          for (var docWorkout in docOfCollectionWorkout.docs) {
            temp = '$workoutCategory $level ${docWorkout.id}';

            listWorkoutInLevel.putIfAbsent(docWorkout.id,
                () => Workout.fromSnap(docWorkout, workoutCategory));
          }
          listLevel.putIfAbsent(level, () => listWorkoutInLevel);
        }
        workouts.value.putIfAbsent(
          idWorkout,
          () => {
            'workoutCategory': workoutCategory,
            'collection': listLevel,
          },
        );
        // print('$idWorkout: ${workouts.value[idWorkout]}');
      }
      update();
      return true;
    } catch (e) {
      print('fetchWorkoutList ------ ${e.toString()}');
      print(temp);
      return false;
    }
  }

  Future<bool> fetchExerciseList() async {
    String? id;
    try {
      CollectionReference<Map<String, dynamic>> listExercise =
          FirebaseFirestore.instance.collection('exercise');
      final data = await listExercise.get();
      print(data.size);
      for (var doc in data.docs) {
        id = doc.id;
        exercises.value.putIfAbsent(doc.id, () => Exercise.fromSnap(doc));
      }
      // exercises.bindStream(
      //   firestore.collection('exercise').snapshots().map(
      //     (event) {
      //       List<Exercise> result = [];
      //       for (var item in event.docs) {
      //         result.add(Exercise.fromSnap(item));
      //       }
      //       return result;
      //     },
      //   ),
      // );
      update();
      return true;
    } catch (e) {
      print('fetchExerciseList ------ ${e.toString()}');
      print('Exercise id:$id');
      return false;
    }
  }

  Future<bool> fetchScheduleList() async {
    try {
      CollectionReference<Map<String, dynamic>> listSchedule =
          FirebaseFirestore.instance.collection('users');
      String userId = AuthService.instance.currentUser!.uid;
      final workoutSchedule =
          await listSchedule.doc(userId).collection('workout_schedule').get();
      // debugPrint('workoutSchedule');
      debugPrint('schedules: ${workoutSchedule.size}');
      for (var docInWorkoutSchedule in workoutSchedule.docs) {
        schedules.value.addAll({
          docInWorkoutSchedule.id:
              WorkoutSchedule.fromSnap(docInWorkoutSchedule)
        });
        // debugPrint('add WorkoutSchedule');'
      }
      debugPrint(schedules.toString());
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> fetchHistoryList() async {
    try {
      CollectionReference<Map<String, dynamic>> listHistory =
          FirebaseFirestore.instance.collection('users');
      String userId = AuthService.instance.currentUser!.uid;
      final workoutHistory =
          await listHistory.doc(userId).collection('workout_history').get();
      // debugPrint('workoutSchedule');
      debugPrint('histories: ${workoutHistory.size}');
      for (var docInWorkoutHistory in workoutHistory.docs) {
        histories.value.addAll({
          docInWorkoutHistory.id: WorkoutHistory.fromSnap(docInWorkoutHistory)
        });
        // debugPrint('add WorkoutSchedule');'
      }
      debugPrint(histories.toString());
      return true;
    } catch (e) {
      rethrow;
    }
  }
}

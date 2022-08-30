import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/tracker_controller.dart';

import 'dailyPlanController/daily_plan_controller.dart';
import '../data/models/workout_model.dart';
import 'package:gold_health/constrains.dart';

class WorkoutPlanController extends GetxController with TrackerController {
  TextEditingController text = TextEditingController();
  RxInt allTime = 60.obs;
  RxInt isReady = 1.obs;
  RxInt currentWorkoutIndex = 0.obs;
  RxList<Map<String, dynamic>> listWorkout = [
    {
      'name': 'Jumping Jacks',
      'time': 20,
      'ready': 10,
      'calo': 300,
    },
    {
      'name': 'Warm Up',
      'time': 20,
      'ready': 10,
      'calo': 400,
    }
  ].obs;

  var exercises = Rx<Map<String, Exercise>>({});
  var workouts = Rx<Map<String, Map<String, dynamic>>>({});
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

  Future<bool> fetchWorkoutList() async {
    String temp = ' ';
    try {
      CollectionReference<Map<String, dynamic>> listWorkout =
          FirebaseFirestore.instance.collection('workout');
      final data = await listWorkout.get();
      // print(data.size);
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
        print('$idWorkout: ${workouts.value[idWorkout]}');
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
}

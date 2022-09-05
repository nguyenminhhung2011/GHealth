import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../enums/workout_enums.dart';

class Workout {
  Workout({
    required this.idWorkout,
    required this.workoutCategory,
    required this.durationWorkout,
    required this.calories,
    required this.level,
    required this.equipmentRequest,
    required this.exercises,
    required this.note,
  });

  final String idWorkout;
  final String workoutCategory;
  final Duration? durationWorkout;
  final int? calories;
  final String level;
  final String? note;
  final List<Map<String, String>>? equipmentRequest; // <nameEquip,imageEquip>
  final List<String> exercises;

  bool isFavorite = false;

  Map<String, dynamic> toJson() => {
        'idWorkout': idWorkout,
        'workoutCategory': workoutCategory,
        'durationWorkout': durationWorkout,
        'calories': calories,
        'level': level,
        'equipmentRequest': equipmentRequest,
        'exercises': exercises,
      };

  factory Workout.fromSnap(DocumentSnapshot snap, String workoutCategory) {
    var snapshot = snap.data() as Map<String, dynamic>;

    // Map<String, String>? equipRe quest;
    // final equipRequestData = snapshot['equipRequest'] as Map<String, dynamic>;
    try {
      List<String> listExercise = [];

      for (var element in (snapshot['exercises'] as List<dynamic>)) {
        listExercise.add(element as String);
      }
      return Workout(
        idWorkout: snap.id,
        workoutCategory: workoutCategory,
        durationWorkout: null,
        calories: null,
        level: snapshot['level'],
        equipmentRequest: null,
        exercises: listExercise,
        note: snapshot['note'],
      );
    } catch (e) {
      rethrow;
    }
  }
}

class Exercise {
  Exercise({
    required this.equipRequest,
    required this.exerciseUrl,
    required this.idExercise,
    required this.exerciseName,
    required this.duration,
    required this.level,
    required this.caloriesBurn,
    required this.description,
    required this.instructions,
    required this.repetitions,
  });

  final String idExercise;
  final String exerciseName;
  final String exerciseUrl;
  final Duration duration;
  final int caloriesBurn;
  final String level;
  final String description;
  final Map<String, String> instructions; //<title,detail>
  final Map<String, String> repetitions; //<times,calories>
  final Map<String, String>? equipRequest;
  bool isFavorite = false;

  Map<String, dynamic> toJson() => {
        'name': exerciseName,
        'exerciseUrl': exerciseUrl,
        'duration': duration,
        'caloriesBurn': caloriesBurn,
        'description': description,
        'level': level,
        'instructions': instructions,
        'repetitions': repetitions,
        'equipRequest': equipRequest,
        'isFavorite': isFavorite,
      };

  factory Exercise.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    Map<String, String> instructions = {};
    List<dynamic> list = snapshot['instructions'];
    for (var element in list) {
      final extractData = element as Map<String, dynamic>;
      Map<String, String> result = {};
      extractData.forEach((key, value) {
        result.addAll({key: value as String});
      });
      instructions.addAll(result);
    }

    Map<String, String> repetitions = {};
    (snapshot['repetitions'] as Map<String, dynamic>).forEach((key, value) {
      repetitions.addAll({
        key: value as String,
      });
    });

    // Map<String, String>?
    // equipRequest;
    // final equipRequestData = snapshot['equipRequest'] as Map<String, dynamic>;

    return Exercise(
      equipRequest: null,
      exerciseUrl: snapshot['exerciseUrl'],
      idExercise: snap.id,
      exerciseName: snapshot['exerciseName'],
      duration: Duration(seconds: int.parse(snapshot['duration'])),
      level: snapshot['level'],
      caloriesBurn: double.parse(snapshot['caloriesBurn']).toInt(),
      description: snapshot['description'],
      instructions: instructions,
      repetitions: repetitions,
    );
  }
}

class WorkoutSchedule {
  const WorkoutSchedule(
      {required this.level,
      required this.repetitions,
      required this.time,
      required this.weight,
      required this.workoutCategory,
      required this.isTurnOn});
  final String level;
  final int repetitions;
  final DateTime time;
  final double weight;
  final String workoutCategory;
  final bool isTurnOn;

  factory WorkoutSchedule.fromSnap(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    // debugPrint(data.toString());
    return WorkoutSchedule(
        level: data['level'] as String,
        repetitions: int.parse(data['repetitions'] as String),
        time: DateTime.fromMillisecondsSinceEpoch(data['time'].seconds * 1000),
        weight: double.parse(data['weight']),
        workoutCategory: data['workoutCategory'],
        isTurnOn: data['isTurnOn']);
  }
}

class WorkoutHistory {
  const WorkoutHistory(
      {required this.level,
      required this.caloriesBurn,
      required this.time,
      required this.workoutCategory});
  final String level;
  final int caloriesBurn;
  final DateTime time;
  final String workoutCategory;

  factory WorkoutHistory.fromSnap(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    // debugPrint(data.toString());
    return WorkoutHistory(
      level: data['level'] as String,
      caloriesBurn: int.parse(data['caloriesBurn'] as String),
      time: DateTime.fromMillisecondsSinceEpoch(data['time'].seconds * 1000),
      workoutCategory: data['workoutCategory'],
    );
  }
}

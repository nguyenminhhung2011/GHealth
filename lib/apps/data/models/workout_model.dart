import '../enums/workout_enums.dart';

class Workout {
  Workout({
    required this.idWorkout,
    required this.workoutCategory,
    required this.durationWorkout,
    required this.calories,
    required this.equipmentRequest,
    required this.exercises,
    required this.isFavorite,
  });

  final String idWorkout;
  final WorkoutCategory workoutCategory;
  final Duration durationWorkout;
  final int calories;
  final List<Map<String, String>> equipmentRequest; // <nameEquip,imageEquip>
  final List<String> exercises;
  bool isFavorite = false;
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
  final Map<String, String> equipRequest;
  bool isFavorite = false;
}

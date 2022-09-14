import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/workout_controller/workout_plan_controller.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/widgets/exercise_card.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/workout_screen.dart';

import '../../data/models/workout_model.dart';
import '../../template/misc/colors.dart';

class ListWorkoutScreen extends StatefulWidget {
  const ListWorkoutScreen({Key? key}) : super(key: key);

  @override
  State<ListWorkoutScreen> createState() => _ListWorkoutScreenState();
}

class _ListWorkoutScreenState extends State<ListWorkoutScreen> {
  var data = Get.arguments as Map<String, dynamic>;
  final _workoutController = Get.find<WorkoutPlanController>();
  late List<ExerciseCard> listExerciseCard = data['listExerciseCard'];
  late Workout workout = data['workout'];
  late List<String> listIdExercise = workout.exercises;
  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            width: widthDevice,
            height: heightDevice,
            color: AppColors.primaryColor1,
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 80,
                  left: 20,
                  right: 20,
                ),
                child: Image.asset(
                  height: widthDevice / 1.7,
                  width: widthDevice / 1.7,
                  'assets/images/yoga.png',
                ),
              ),
            ),
          ),
          SizedBox(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: ListView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: heightDevice * 0.35,
                        width: widthDevice,
                      ),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: heightDevice * 0.86),
                        child: Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 65,
                                  height: 7,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor1
                                        .withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor1
                                              .withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/clock.png',
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              '00:45:00',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.amber.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/calories.png',
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              '78 Calories',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Preview exercises',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  height: 0.5,
                                  width: double.infinity,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 20),
                                Column(
                                  children: listExerciseCard,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.more_horiz,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  // Updating
                  Get.to(() => const WorkoutScreen(),
                          arguments: listIdExercise)!
                      .then((value) {
                    if (value) {
                      String caloriesBurn = _workoutController
                          .getCaloriesBurnFromWorkout(workout.exercises);
                      String duration = _workoutController
                          .getDurationFromWorkout(workout.exercises);
                      _workoutController.addWorkoutHistory({
                        'caloriesBurn': caloriesBurn,
                        'duration': duration,
                        'level': workout.level,
                        'time': Timestamp.fromDate(
                            DateTime.now().add(const Duration(seconds: 1))),
                        'workoutCategory': workout.workoutCategory
                      });
                    }
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: widthDevice * 0.6,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.primaryColor1,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(2, 3),
                        blurRadius: 2,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(-2, -3),
                        blurRadius: 2,
                      )
                    ],
                  ),
                  child: const Text(
                    'Start Workout',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          )
        ],
      ),
    );
  }
}

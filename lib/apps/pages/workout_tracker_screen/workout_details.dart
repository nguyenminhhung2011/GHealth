import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/workout_controller/workout_plan_controller.dart';
import 'package:gold_health/apps/data/enums/workout_enums.dart';
import 'package:gold_health/apps/data/models/workout_model.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/list_workout_screen.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/widgets/exercise_card.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/widgets/appBar_workout_screen.dart';
import '../../template/misc/colors.dart';

class WorkoutDetailScreen extends StatefulWidget {
  const WorkoutDetailScreen({Key? key}) : super(key: key);
  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  final _workoutController = Get.find<WorkoutPlanController>();
  final List<ExerciseCard> listExerciseCard = [];
  final List<String> listIdExercise = [];
  final workout = (Get.arguments as Map<String, dynamic>)['workout'] as Workout;
  final workoutCategory =
      (Get.arguments as Map<String, dynamic>)['workoutCategory'] as String;
  bool _initSate = true;
  Future<bool> _getAndSetUpData() async {
    String? temp;
    if (!_initSate) return true;
    try {
      temp = '1';
      listExerciseCard.clear();
      for (var element in workout.exercises) {
        print(element);
        listIdExercise
            .add(_workoutController.exercises.value[element]!.idExercise);
        listExerciseCard.add(
          ExerciseCard(widthDevice: Get.mediaQuery.size.width, e: {
            'id': _workoutController.exercises.value[element]!.idExercise,
            'url': _workoutController.exercises.value[element]!.exerciseUrl,
            'name': _workoutController.exercises.value[element]!.exerciseName,
            'time':
                _workoutController.exercises.value[element]!.duration.inSeconds,
          }),
        );
      }
      _initSate = false;
      return true;
    } catch (e) {
      print('_getAndSetUpData: $e');
      print(temp);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: _getAndSetUpData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            if (snapshot.data as bool) {
              return Scaffold(
                backgroundColor: AppColors.mainColor,
                extendBody: true,
                extendBodyBehindAppBar: true,
                body: Stack(
                  children: [
                    Container(
                      width: widthDevice,
                      height: heightDevice,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor1,
                      ),
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
                                  constraints: BoxConstraints(
                                      minHeight: heightDevice * 0.86),
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 65,
                                            height: 7,
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryColor1
                                                  .withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                          const SizedBox(height: 30),
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Fullbody Workout',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${workout.exercises.length} Exercises | 32 mins | 320 Calories Burn',
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors
                                                        .primaryColor1
                                                        .withOpacity(0.2),
                                                  ),
                                                  child: Icon(
                                                    Icons.favorite,
                                                    color: Colors.red
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          Row(
                                            children: const [
                                              Text(
                                                'You \'ll Need',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                '5 Items',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                ToolsCard(
                                                  widthDevice: widthDevice,
                                                  imagePath:
                                                      'assets/images/jump-rope.png',
                                                  title: 'Jump Rope',
                                                ),
                                                ToolsCard(
                                                  widthDevice: widthDevice,
                                                  imagePath:
                                                      'assets/images/plastic-bottle.png',
                                                  title: 'Plastic Bottle',
                                                ),
                                                ToolsCard(
                                                  widthDevice: widthDevice,
                                                  imagePath:
                                                      'assets/images/barbel.png',
                                                  title: 'Barbel',
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 30),
                                          Row(
                                            children: [
                                              const Text(
                                                'Exercises',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                '${workout.exercises.length} exercises',
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
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
                        AppBarWorkout(title: '', press: () {}),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Get.to(() => const ListWorkoutScreen(), arguments: {
                              'listExerciseCard': listExerciseCard,
                              'workout': workout
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
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ToolsCard extends StatelessWidget {
  const ToolsCard({
    Key? key,
    required double widthDevice,
    required this.imagePath,
    required this.title,
  })  : _widthDevice = widthDevice,
        super(key: key);

  final double _widthDevice;
  final String imagePath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            height: _widthDevice / 3,
            width: _widthDevice / 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.withOpacity(0.1),
            ),
            child: Image.asset(
              imagePath,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

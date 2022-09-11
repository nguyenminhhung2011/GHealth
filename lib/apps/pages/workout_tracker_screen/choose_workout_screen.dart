import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/workout_controller/workout_plan_controller.dart';
import 'package:gold_health/apps/data/models/workout_model.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/widgets/appBar_workout_screen.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/widgets/workout_routine_card.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/workout_details.dart';
import 'package:intl/intl.dart';
import '../../template/misc/colors.dart';

class ChoseWorkoutScreen extends StatefulWidget {
  const ChoseWorkoutScreen({Key? key}) : super(key: key);

  @override
  State<ChoseWorkoutScreen> createState() => _ChoseWorkoutScreenState();
}

class _ChoseWorkoutScreenState extends State<ChoseWorkoutScreen> {
  final _workoutController = Get.find<WorkoutPlanController>();
  final List<WorkoutRoutineCard> _listWorkoutRoutineCard = [];
  final idWorkout = Get.arguments as String;
  late String workoutCategory;
  bool _initSate = true;
  Future<bool> _getAndSetUpData() async {
    String? temp;
    if (!_initSate) return true;
    try {
      temp = '1';
      //Extract data from according level in collection idWorkout/....
      final listExercisesAccordingLevel = _workoutController
          .workouts.value[idWorkout]?['collection'] as Map<String, dynamic>;
      workoutCategory = _workoutController.workouts.value[idWorkout]
          ?['workoutCategory'] as String;
      _listWorkoutRoutineCard.clear();
      //Extract data form workout in collection
      listExercisesAccordingLevel.forEach((key, value) {
        //key == level
        temp = '2';
        final data = value as Map<String, dynamic>;

        //Extract data from List workout
        Map<String, Workout> extractData = {};
        data.forEach((key, value) {
          extractData.addAll({key: value as Workout});
        });
        extractData.forEach((key, workout) {
          _listWorkoutRoutineCard.add(
            WorkoutRoutineCard(
              title: workout.note!,
              subTitle: workout.level,
              getToPage: () => getToWorkoutDetailPage(workout),
            ),
          );
        });
      });
      _initSate = false;
      return true;
    } catch (e) {
      print('_getAndSetUpData: $e');
      print(temp);
      return false;
    }
  }

  void getToWorkoutDetailPage(Workout workout) {
    Get.to(() => const WorkoutDetailScreen(),
        arguments: {'workout': workout, 'workoutCategory': workoutCategory});
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
                            'assets/images/exercise.png',
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
                                                  Text(
                                                    workoutCategory,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
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
                                          Column(
                                            children: [
                                              InkWell(
                                                //borderRadius: BorderRadius.circular(20),
                                                onTap: showTimePicker,
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20,
                                                      vertical: 18),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: AppColors
                                                        .primaryColor1
                                                        .withOpacity(0.3),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/icons/Calendar.svg',
                                                          color: Colors.grey),
                                                      const SizedBox(width: 5),
                                                      const Text(
                                                        'Schedule Workout',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Obx(() => Text(
                                                            DateFormat.yMd()
                                                                .add_jm()
                                                                .format(
                                                                    _workoutController
                                                                        .alarmTime
                                                                        .value),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          )),
                                                      const SizedBox(width: 5),
                                                      const Icon(
                                                        Icons
                                                            .arrow_forward_ios_sharp,
                                                        color: Colors.grey,
                                                        size: 15,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              InkWell(
                                                onTap: showLevelDialog,
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20,
                                                      vertical: 18),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: AppColors
                                                        .primaryColor2
                                                        .withOpacity(0.3),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/icons/Swap.svg',
                                                          color: Colors.grey),
                                                      const SizedBox(width: 5),
                                                      const Text(
                                                        'Difficulty',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Obx(() => Text(
                                                            _workoutController
                                                                .level.value,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          )),
                                                      const SizedBox(width: 5),
                                                      const Icon(
                                                        Icons
                                                            .arrow_forward_ios_sharp,
                                                        color: Colors.grey,
                                                        size: 15,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          const SizedBox(height: 30),
                                          Row(
                                            children: [
                                              const Text(
                                                'Some Workout Routine',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                '${_listWorkoutRoutineCard.length} routine',
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          Column(
                                            children: _listWorkoutRoutineCard,
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
                        AppBarWorkout(
                          title: '',
                          press: () {},
                        ),
                      ],
                    ),
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

  showLevelDialog() {
    String tempLevel = 'Beginner';
    List<String> listLevel = ['Beginner', 'Intermediate', 'Advanced'];
    List<Widget> listText = [];
    for (String element in listLevel) {
      listText.add(Center(
        child: Text(
          element,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ));
    }
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 260,
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 180,
              child: CupertinoPicker(
                itemExtent: 64,
                onSelectedItemChanged: (value) => tempLevel = listLevel[value],
                children: listText,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _workoutController.level.value = tempLevel;
                        Get.back();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.primaryColor1),
                        child: const Text(
                          'Done',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  showTimePicker() {
    DateTime timeTemp = DateTime.now();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 260,
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 180,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (value) {
                  timeTemp = value;
                },
                initialDateTime: DateTime.now(),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _workoutController.alarmTime.value = timeTemp;
                        Get.back();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.primaryColor1),
                        child: const Text(
                          'Done',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
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

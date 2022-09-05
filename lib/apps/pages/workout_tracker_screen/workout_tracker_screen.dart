import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/workout_controller/workout_plan_controller.dart';
import 'package:gold_health/apps/data/models/workout_model.dart';
import 'package:gold_health/apps/global_widgets/screen_template.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/choose_workout_screen.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/widgets/categories_workout_card.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/widgets/up_coming_workout_containerd.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/workout_history_screen.dart';
import 'package:intl/intl.dart';

import '../../global_widgets/button_custom/Button_icon_gradient_color.dart';
import '../../global_widgets/row_text_see_more.dart';
import '../../global_widgets/list_chart/line_chart2_line.dart';
import '../../routes/route_name.dart';
import '../../template/misc/colors.dart';
import '../dashboard/widgets/button_gradient.dart';

class WorkoutTrackerScreen extends StatefulWidget {
  const WorkoutTrackerScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutTrackerScreen> createState() => _WorkoutTrackerScreenState();
}

class _WorkoutTrackerScreenState extends State<WorkoutTrackerScreen> {
  final controller = Get.put(WorkoutPlanController());

  Map<String, String> listWorkoutID = {};

  List<Padding> listWorkoutSchedule = [];

  Future<bool> _fetchData() async {
    try {
      await controller.fetchExerciseList();
      await controller.fetchWorkoutList();
      await controller.fetchScheduleList();
      await controller.fetchHistoryList();
      await _addListWorkoutSchedule();
      controller.workouts.value.forEach((key, value) {
        listWorkoutID.addAll({(value['workoutCategory'] as String): key});
      });
      // debugPrint(listWorkoutID.toString());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> _addListWorkoutSchedule() async {
    try {
      final schedules = controller.schedules.value;
      schedules.forEach((key, value) {
        listWorkoutSchedule.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: UpComingWorkoutContainer(
            val: value.isTurnOn,
            main: value.workoutCategory,
            time: DateFormat.yMd().add_jm().format(value.time),
            imagePath: controller.listImage[value.workoutCategory] as String,
          ),
        ));
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    // var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    List<String> tabs = [
      'Nutrition',
      'Workout',
      'Foot step',
      'Water',
      'Fasting',
      'Sleep',
    ];
    // final WorkoutApi tests = WorkoutApi();
    // tests.getData();
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
          future: _fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                if (snapshot.data as bool) {
                  return ScreenTemplate(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(
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
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          int? newIndex;
                                          await _showDialogMethod(
                                            context: context,
                                            tabs: tabs,
                                            onselectedTabs: (value) {
                                              newIndex = value;
                                            },
                                            done: () {
                                              print(newIndex);
                                              if (newIndex != null) {
                                                controller
                                                    .changeTab(newIndex ?? 0);
                                              } else {
                                                controller.changeTab(0);
                                              }
                                              Navigator.pop(context);
                                            },
                                          );
                                        },
                                        child: Row(
                                          children: const [
                                            Text(
                                              'Workout Planner',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Icon(
                                              Icons
                                                  .keyboard_arrow_down_outlined,
                                              color: Colors.black,
                                              size: 24,
                                            )
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          Get.to(() =>
                                              const WorkoutHistoryScreen());
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor1
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Icon(
                                            Icons.history,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Text(
                                        'Workout ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .copyWith(
                                              fontSize: 17,
                                            ),
                                      ),
                                      const Spacer(),
                                      ButtonIconGradientColor(
                                        title: ' Week',
                                        icon: Icons.calendar_month,
                                        press: () {},
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: widthDevice,
                                    height: 200,
                                    // ignore: avoid_unnecessary_containers
                                    child: Container(
                                      child: const LineChartTwoLine(),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 25,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: AppColors.colorGradient2,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Daily Workout Schedule',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4!
                                              .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                              ),
                                        ),
                                        const Spacer(),
                                        ButtonGradient(
                                          height: 40.0,
                                          width: 90.0,
                                          linearGradient: const LinearGradient(
                                            colors: [
                                              AppColors.primaryColor1,
                                              AppColors.primaryColor1,
                                            ],
                                          ),
                                          onPressed: () {
                                            Get.toNamed(RouteName
                                                .workoutScheduleScreen);
                                          },
                                          title: const Text(
                                            'Check',
                                            style: TextStyle(
                                              fontFamily: 'Sen',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  RowText_Seemore(
                                    press: () {},
                                    title: 'Upcoming Workout',
                                  ),
                                  const SizedBox(height: 15),
                                  Column(
                                    children: listWorkoutSchedule,
                                  ),
                                  const SizedBox(height: 20),
                                  RowText_Seemore(
                                    press: () {
                                      Get.to(() => SeeMoreWorkoutScreen(
                                          listWorkoutID: listWorkoutID));
                                    },
                                    title: 'What Do You Want to Train',
                                  ),
                                  const SizedBox(height: 15),
                                  Column(
                                    children: [
                                      CategoriesWorkoutCard(
                                        cate_name: 'Upperbody Workout',
                                        press: () {
                                          Get.to(
                                              () => const ChoseWorkoutScreen(),
                                              arguments:
                                                  listWorkoutID['Upperbody']
                                                      as String);
                                        },
                                        imagePath:
                                            'assets/images/upperbody.png',
                                        exer: 12,
                                        time: 40,
                                      ),
                                      CategoriesWorkoutCard(
                                        cate_name: 'Lowebody Workout',
                                        press: () {
                                          Get.to(
                                              () => const ChoseWorkoutScreen(),
                                              arguments:
                                                  listWorkoutID['Lowebody']
                                                      as String);
                                        },
                                        imagePath: 'assets/images/lowebody.png',
                                        exer: 12,
                                        time: 40,
                                      ),
                                      CategoriesWorkoutCard(
                                        cate_name: 'Fullbody Workout',
                                        press: () {
                                          Get.to(
                                              () => const ChoseWorkoutScreen(),
                                              arguments:
                                                  listWorkoutID['Fullbody']
                                                      as String);
                                        },
                                        imagePath: 'assets/images/fullbody.png',
                                        exer: 11,
                                        time: 32,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  print('Some thing went wrong');
                }
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  _showDialogMethod({
    required BuildContext context,
    required List<String> tabs,
    required Function(int)? onselectedTabs,
    required Function() done,
  }) async {
    await showDialog(
      useRootNavigator: false,
      barrierColor: Colors.black54,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            alignment: Alignment.center,
            height: 300,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.mainColor,
              //   color: Colors.transparent,
            ),
            child: Column(
              children: [
                Container(
                  height: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: CupertinoPicker(
                    onSelectedItemChanged: onselectedTabs,
                    selectionOverlay: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 3, color: AppColors.primaryColor1),
                      ),
                    ),
                    itemExtent: 50,
                    diameterRatio: 1.2,
                    children: [
                      for (var item in tabs)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            item,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.primaryColor1,
                  ),
                  child: ElevatedButton(
                    onPressed: done,
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SeeMoreWorkoutScreen extends StatelessWidget {
  const SeeMoreWorkoutScreen({Key? key, required this.listWorkoutID})
      : super(key: key);
  final Map<String, String> listWorkoutID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenTemplate(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.approxWhite,
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Workout',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.approxWhite,
                        ),
                        child: const Icon(
                          Icons.more_horiz,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CategoriesWorkoutCard(
                  cate_name: 'Upperbody Workout',
                  press: () {
                    Get.to(() => const ChoseWorkoutScreen(),
                        arguments: listWorkoutID['Upperbody'] as String);
                  },
                  imagePath: 'assets/images/upperbody.png',
                  exer: 12,
                  time: 40,
                ),
                CategoriesWorkoutCard(
                  cate_name: 'Lowebody Workout',
                  press: () {
                    Get.to(() => const ChoseWorkoutScreen(),
                        arguments: listWorkoutID['Lowebody'] as String);
                  },
                  imagePath: 'assets/images/lowebody.png',
                  exer: 12,
                  time: 40,
                ),
                CategoriesWorkoutCard(
                  cate_name: 'ABS Workout',
                  press: () {
                    Get.to(() => const ChoseWorkoutScreen(),
                        arguments: listWorkoutID['Abs'] as String);
                  },
                  imagePath: 'assets/images/abs.png',
                  exer: 14,
                  time: 20,
                ),
                CategoriesWorkoutCard(
                  cate_name: 'Fullbody Workout',
                  press: () {
                    Get.to(() => const ChoseWorkoutScreen(),
                        arguments: listWorkoutID['Fullbody'] as String);
                  },
                  imagePath: 'assets/images/fullbody.png',
                  exer: 11,
                  time: 32,
                ),
                CategoriesWorkoutCard(
                  cate_name: 'Cardio Workout',
                  press: () {
                    Get.to(() => const ChoseWorkoutScreen(),
                        arguments: listWorkoutID['Cardio'] as String);
                  },
                  imagePath: 'assets/images/cardio.png',
                  exer: 14,
                  time: 20,
                ),
                CategoriesWorkoutCard(
                  cate_name: 'Hitt Workout',
                  press: () {
                    Get.to(() => const ChoseWorkoutScreen(),
                        arguments: listWorkoutID['Cardio'] as String);
                  },
                  imagePath: 'assets/images/hitt.png',
                  exer: 14,
                  time: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

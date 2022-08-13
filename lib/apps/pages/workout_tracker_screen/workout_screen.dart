import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gold_health/apps/pages/list_plan_screen/selectAmountFood.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/widgets/appBar_workout_screen.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/widgets/circle_progress.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../template/misc/colors.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen>
    with SingleTickerProviderStateMixin {
  static const maxSeconds = 60;
//  int seconds = maxSeconds;

  bool _checkContinue = false;
  late AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 200),
  );
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 200),
    );
    _animation = Tween<double>(begin: 0, end: 200).animate(_animationController)
      ..addListener(
        () {
          setState(() {});
        },
      );
  }

  void initAnimation(int value) {
    setState(() {
      _animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: value),
      );
      _animation = Tween<double>(begin: 0, end: value.toDouble())
          .animate(_animationController)
        ..addListener(
          () {
            setState(() {});
          },
        );
    });
  }

  Widget build(BuildContext context) {
    var _heightDevice = MediaQuery.of(context).size.height;
    var _widthDevice = MediaQuery.of(context).size.width;
    bool val = true;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.primaryColor1,
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
                        height: _heightDevice * 0.08,
                        width: _widthDevice,
                      ),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: _heightDevice * 0.95),
                        child: Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
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
                                const Text(
                                  '2/120 Exercises',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  width: _widthDevice,
                                  height: _heightDevice * 0.5,
                                  decoration: BoxDecoration(),
                                  child: Image.asset(
                                    'assets/gift/Workout2.gif',
                                  ),
                                ),
                                const Divider(),
                                const SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: CircularPercentIndicator(
                                            circularStrokeCap:
                                                CircularStrokeCap.round,
                                            percent: 0.6,
                                            progressColor:
                                                AppColors.primaryColor2,
                                            backgroundColor:
                                                Colors.grey.withOpacity(0.2),
                                            radius: 70,
                                            curve: Curves.linear,
                                            backgroundWidth: 7,
                                            lineWidth: 7,
                                            center: CircularPercentIndicator(
                                              circularStrokeCap:
                                                  CircularStrokeCap.round,
                                              percent: 0.3,
                                              progressColor:
                                                  AppColors.primaryColor1,
                                              backgroundColor:
                                                  Colors.grey.withOpacity(0.2),
                                              radius: 60,
                                              curve: Curves.linear,
                                              backgroundWidth: 7,
                                              lineWidth: 7,
                                              center: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Container(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text(
                                                        'Ready',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const Text(
                                                        '00:00',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        radius: 40,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        onTap: () {},
                                                        child: const Icon(
                                                          Icons.play_circle,
                                                          color: AppColors
                                                              .primaryColor1,
                                                          size: 35,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            padding: const EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              color: AppColors.mainColor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.05),
                                                  offset: const Offset(2, 3),
                                                  blurRadius: 10,
                                                ),
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.05),
                                                  offset: const Offset(-2, -3),
                                                  blurRadius: 10,
                                                )
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Jumping Jacks',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                        'assets/images/calories.png',
                                                        height: 15,
                                                        width: 15),
                                                    const RichTextCustom(
                                                      size: 15,
                                                      title:
                                                          'Calories Burned: ',
                                                      data: 300,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                        'assets/images/duration.png',
                                                        height: 15,
                                                        width: 15),
                                                    const RichTextCustom(
                                                      size: 15,
                                                      title: 'Time: ',
                                                      data: 45,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Container(
                                                  height: 40,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color:
                                                        AppColors.primaryColor1,
                                                  ),
                                                  child: ElevatedButton(
                                                    onPressed: () {},
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            primary: Colors
                                                                .transparent,
                                                            shadowColor: Colors
                                                                .transparent),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Text(
                                                          'Skip',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 2),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: AppColors
                                                              .mainColor,
                                                          size: 17,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
                                      ],
                                    ),
                                  ],
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
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: AppBarWorkout(title: 'Warm Up', press: () {}),
          ),
        ],
      ),
    );
  }
}

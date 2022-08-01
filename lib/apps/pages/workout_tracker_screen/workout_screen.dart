import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/widgets/appBar_workout_screen.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/widgets/circle_progress.dart';

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
              decoration: BoxDecoration(
                color: AppColors.primaryColor1,
              ),
              child: ListView(
                physics: BouncingScrollPhysics(
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
                          padding: EdgeInsets.symmetric(
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
                                Text(
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
                                Container(
                                  width: _widthDevice,
                                  height: 0.5,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: (100 - 60) / 2 + 10),
                                const SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Center(),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: AppColors.primaryColor1,
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                primary: Colors.transparent,
                                                shadowColor:
                                                    Colors.transparent),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.arrow_back_ios,
                                                  color: AppColors.mainColor,
                                                  size: 17,
                                                ),
                                                const SizedBox(width: 2),
                                                Text(
                                                  'Previous',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: AppColors.primaryColor1,
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                primary: Colors.transparent,
                                                shadowColor:
                                                    Colors.transparent),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Skip',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                const SizedBox(width: 2),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: AppColors.mainColor,
                                                  size: 17,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
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
          AppBarWorkout(title: 'Warm Up', press: () {}),
        ],
      ),
    );
  }
}

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
    duration: Duration(seconds: 9),
  );
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 9),
    );
    _animation = Tween<double>(begin: 0, end: 9).animate(_animationController)
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
                                CircleCountdown(
                                  animation: _animation,
                                  checkContinue: _checkContinue,
                                  press: () {},
                                  radius: 60,
                                  strokeCircle: 12,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          '${_animation.value.toInt()}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 27,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              _checkContinue = !_checkContinue;
                                            });
                                            if (_checkContinue) {
                                              _animationController.forward();
                                            } else {
                                              _animationController.stop();
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryColor1,
                                              shape: BoxShape.circle,
                                            ),
                                            child: (!_checkContinue)
                                                ? Icon(
                                                    Icons.play_arrow,
                                                    color: Colors.white,
                                                    size: 30,
                                                  )
                                                : Icon(
                                                    Icons.pause,
                                                    color: Colors.white,
                                                    size: 30,
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
                                        CircleCountdown(
                                          animation: _animation,
                                          checkContinue: _checkContinue,
                                          strokeCircle: 5,
                                          press: () {},
                                          radius: 30,
                                          child: Center(
                                            child: Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryColor1,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Text(
                                                '${(_animation.value.toInt() / 60).toInt()}:${_animation.value.toInt() - ((_animation.value.toInt() / 60).toInt() * 60)}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
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
          Column(
            children: [
              const SizedBox(height: 50),
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
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Warm Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.more_horiz,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CircleCountdown extends StatelessWidget {
  const CircleCountdown({
    Key? key,
    required Animation<double> animation,
    required bool checkContinue,
    required this.press,
    required this.radius,
    required this.child,
    required this.strokeCircle,
  })  : _animation = animation,
        _checkContinue = checkContinue,
        super(key: key);

  final Animation<double> _animation;
  final bool _checkContinue;
  final Function() press;
  final double radius;
  final double strokeCircle;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: CircleProgress(
        _animation.value,
        9,
        radius,
        strokeCircle,
      ),
      child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            //    color: Colors.blue,
            shape: BoxShape.circle,
          ),
          child: child),
    );
  }
}

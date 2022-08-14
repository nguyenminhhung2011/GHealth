import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/workout_plan_controller.dart';
import 'package:gold_health/apps/global_widgets/screenTemplate.dart';
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

class _WorkoutScreenState extends State<WorkoutScreen> {
  final _controller = Get.find<WorkoutPlanController>();
  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    bool val = true;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: ScreenTemplate(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primaryColor1,
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
                      color: AppColors.primaryColor1,
                    ),
                    child: const Icon(
                      Icons.more_horiz,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Jumping Jacks',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 5),
                Icon(Icons.check_circle, color: AppColors.primaryColor1)
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              '2/120 Exercises',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: widthDevice,
              height: heightDevice * 0.55,
              decoration: BoxDecoration(color: AppColors.mainColor),
              child: Image.asset(
                'assets/gift/Workout2.gif',
              ),
            ),
            const Divider(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // ignore: prefer_const_constructors
                Obx(
                  () => Expanded(
                    // ignore: prefer_const_constructors
                    child: CountTImeWorkout(
                      currentAllTime:
                          Duration(seconds: _controller.allTime.value),
                      // ignore: invalid_use_of_protected_member
                      currentTime: Duration(
                          seconds: _controller.listWorkout
                                  .value[_controller.currentWorkoutIndex.value]
                              ['time']),
                      currentReadyTime: Duration(
                          seconds: _controller.listWorkout
                                  .value[_controller.currentWorkoutIndex.value]
                              ['ready']),
                      isReady: _controller.isReady.value,
                      onComPleted: () {
                        _controller.isReady.value = !_controller.isReady.value;
                        if (_controller.isReady.value &&
                            _controller.currentWorkoutIndex.value <
                                _controller.listWorkout.value.length) {
                          _controller.currentWorkoutIndex.value++;
                        }
                        print(_controller.isReady.value);
                      },
                    ),
                  ),
                ),
                Obx(
                  () => Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          offset: const Offset(2, 3),
                          blurRadius: 10,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          offset: const Offset(-2, -3),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _controller.listWorkout
                                  .value[_controller.currentWorkoutIndex.value]
                              ['name'],
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Image.asset('assets/images/calories.png',
                                height: 15, width: 15),
                            RichTextCustom(
                              size: 15,
                              title: 'Calories Burned: ',
                              data: _controller.listWorkout.value[_controller
                                  .currentWorkoutIndex.value]['calo'],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Image.asset('assets/images/duration.png',
                                height: 15, width: 15),
                            RichTextCustom(
                              size: 15,
                              title: 'Time: ',
                              data: _controller.listWorkout.value[_controller
                                  .currentWorkoutIndex.value]['time'],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.primaryColor1,
                          ),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
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
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CountTImeWorkout extends StatefulWidget {
  const CountTImeWorkout({
    Key? key,
    required this.currentTime,
    required this.currentAllTime,
    this.isReady,
    required this.onComPleted,
    required this.currentReadyTime,
  }) : super(key: key);
  final Duration currentTime;
  final Duration currentAllTime;
  final Duration currentReadyTime;
  final bool? isReady;
  final VoidCallback onComPleted;
  @override
  State<CountTImeWorkout> createState() => _CountTImeWorkoutState();
}

class _CountTImeWorkoutState extends State<CountTImeWorkout>
    with TickerProviderStateMixin {
  AnimationController? _controllerCurrentTime;
  AnimationController? _controllerAllTime;
  double progress = 0;
  double progressAll = 0;
  RxBool isPlay = true.obs;
  String get countText {
    Duration count =
        _controllerCurrentTime!.duration! * _controllerCurrentTime!.value;
    int minute = (count.inMinutes - count.inHours * 60);
    int seconds = (count.inSeconds - count.inMinutes * 60);
    return '$minute:$seconds';
  }

  @override
  void onComplete() {
    if (widget.onComPleted != null) {
      widget.onComPleted();
      if (widget.isReady == true) {
        _controllerCurrentTime!.stop();
        _controllerCurrentTime =
            AnimationController(vsync: this, duration: widget.currentTime);
        _controllerCurrentTime!.forward(from: _controllerCurrentTime!.value);
      } else {
        _controllerCurrentTime!.stop();
        _controllerCurrentTime =
            AnimationController(vsync: this, duration: widget.currentReadyTime);
        _controllerCurrentTime!.forward(from: _controllerCurrentTime!.value);
      }
      _controllerCurrentTime!.addStatusListener((status) {
        switch (status) {
          case AnimationStatus.forward:
            break;
          case AnimationStatus.completed:
            onComplete();
            break;
          default:
            break;
        }
      });
    }
  }

  void initState() {
    super.initState();
    _controllerCurrentTime =
        AnimationController(vsync: this, duration: widget.currentReadyTime);
    _controllerAllTime =
        AnimationController(vsync: this, duration: widget.currentAllTime);
    _controllerCurrentTime!.addListener(() {
      setState(() {
        progress = _controllerCurrentTime!.value;
      });
    });
    _controllerCurrentTime!.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.forward:
          break;
        case AnimationStatus.completed:
          onComplete();
          break;
        default:
          break;
      }
    });
    _controllerAllTime!.addListener(() {
      setState(() {
        progressAll = _controllerAllTime!.value;
      });
    });
    _controllerCurrentTime!.forward(from: _controllerCurrentTime!.value);
    _controllerAllTime!.forward(from: _controllerAllTime!.value);
  }

  @override
  void dispose() {
    if (_controllerAllTime != null) {
      _controllerAllTime?.dispose();
    }
    if (_controllerCurrentTime != null) {
      _controllerCurrentTime?.dispose();
    }
    super.dispose();
  }

  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      circularStrokeCap: CircularStrokeCap.round,
      percent: progressAll,
      progressColor: AppColors.primaryColor2,
      backgroundColor: Colors.grey.withOpacity(0.2),
      radius: 70,
      curve: Curves.linear,
      backgroundWidth: 7,
      lineWidth: 7,
      center: CircularPercentIndicator(
        circularStrokeCap: CircularStrokeCap.round,
        percent: _controllerCurrentTime!.value,
        progressColor: AppColors.primaryColor1,
        backgroundColor: Colors.grey.withOpacity(0.2),
        radius: 60,
        curve: Curves.linear,
        backgroundWidth: 7,
        lineWidth: 7,
        onAnimationEnd: () {
          setState(() {
            widget.onComPleted;
          });
        },
        center: Padding(
          padding: const EdgeInsets.all(10),
          // ignore: avoid_unnecessary_containers
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (widget.isReady!) ? 'Ready' : 'Workout',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Text(
                  countText,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                InkWell(
                  radius: 40,
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    if (isPlay.value) {
                      _controllerCurrentTime!.stop();
                      _controllerAllTime!.stop();
                    } else {
                      _controllerCurrentTime!
                          .forward(from: _controllerCurrentTime!.value);
                      _controllerAllTime!
                          .forward(from: _controllerAllTime!.value);
                    }
                    isPlay.value = !isPlay.value;
                  },
                  child: Obx(
                    () => Icon(
                      isPlay.value
                          ? Icons.pause_circle_filled_rounded
                          : Icons.play_circle_fill_rounded,
                      color: AppColors.primaryColor1,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

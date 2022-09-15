import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/fasting_plan_controller.dart';
import 'package:gold_health/constrains.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'package:gold_health/main.dart' show sharedPreferencesOfApp;

import '../../../../services/notification.dart';

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({Key? key, required this.duration}) : super(key: key);
  final Duration duration;
  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  final fastingPlanController = Get.find<FastingPlanController>();
  late AnimationController _controllerOpacity;
  late Animation<double> _animationOpacity;
  late AnimationController? _controller;

  var isPlay = false.obs;
  var isFinish = false.obs;
  var progress = 0.00.obs;

  void stopProgress() {
    isPlay.value = !isPlay.value;
  }

  String get countText {
    Duration count = _controller!.duration! * _controller!.value;
    if (fastingPlanController.isRemainMode.value) {
      count = widget.duration - count;
    }
    int hour = count.inHours;
    int minute = (count.inMinutes - count.inHours * 60);
    int second = (count.inSeconds - count.inMinutes * 60);
    return '$hour:$minute:$second';
  }

  @override
  void initState() {
    super.initState();
    _controllerOpacity = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 600,
      ),
    );
    _animationOpacity = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controllerOpacity, curve: Curves.easeIn));
  }

  Future<bool> prepareForData() async {
    await Future(() {
      double value =
          (sharedPreferencesOfApp.getInt('controllerDuration')?.toDouble() ??
                  0) /
              (sharedPreferencesOfApp.getInt('endDuration')?.toDouble() ?? 1);
      print('prepareForDataValue: $value');
      _controller = AnimationController(vsync: this, duration: widget.duration);
      _controller!.value = value;
      _controller!.addListener(() {
        progress.value = _controller!.value;
        if (_controller!.isCompleted) {
          _controller!.stop();
          isFinish.value = true;
          _controllerOpacity.forward();
          isPlay.value = false;
        }
      });
      isPlay.value = sharedPreferencesOfApp.getBool('isPlaying') ?? false;
      if (isPlay.value) {
        _controller!.forward();
      }
      print('isPlay.value: ${isPlay.value}');
    });
    return true;
  }

  @override
  void dispose() async {
    sharedPreferencesOfApp.remove('isPlaying');
    sharedPreferencesOfApp.remove('isFasting');
    sharedPreferencesOfApp.remove('index');
    sharedPreferencesOfApp.remove('endDuration');
    sharedPreferencesOfApp.reload();
    // Workmanager().registerOneOffTask(
    //   'createFasting',
    //   'save_value_count_down_controller',
    //   inputData: {
    //     'isPlaying': isPlay.value,
    //     'indexOfListChoice': fastingPlanController.indexOfChoice,
    //     'endDuration': widget.duration.inSeconds,
    //     'controllerDuration':
    //         (_controller!.value * _controller!.duration!.inSeconds).toInt()
    //   },
    // );

    Map<String, dynamic> inputData = {
      'isPlaying': isPlay.value,
      'indexOfListChoice': fastingPlanController.indexOfChoice,
      'endDuration': widget.duration.inSeconds,
      'controllerDuration':
          (_controller!.value * _controller!.duration!.inSeconds).toInt()
    };

    DateTime time = DateTime.now().add(widget.duration);
    createFastingNotificationAuto(
        NotificationCalendar.fromDate(
          date: time,
        ),
        inputData);
    _controllerOpacity.dispose();
    _controller!.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: prepareForData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              if (snapshot.data as bool) {
                return Column(
                  children: [
                    Obx(
                      () => CircularPercentIndicator(
                        center: Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: isFinish.value
                              ? FadeTransition(
                                  opacity: _animationOpacity,
                                  child: const CongratulationCenter(),
                                )
                              : Obx(
                                  () => CountDownCenter(
                                    controller: _controller,
                                    countText: countText,
                                    stopProgress: stopProgress,
                                    duration: widget.duration,
                                    progress: progress.value,
                                    isPlay: isPlay.value,
                                  ),
                                ),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        percent: fastingPlanController.isRemainMode.value
                            ? 1 - progress.value
                            : progress.value,
                        reverse: fastingPlanController.isRemainMode.value,
                        curve: Curves.linear,
                        progressColor: Colors.lightBlue[300],
                        backgroundColor: Colors.blueGrey[50]!,
                        lineWidth: 27,
                        radius: Get.mediaQuery.size.width * 0.4,
                        backgroundWidth: 22,
                      ),
                    ),
                  ],
                );
              }
            }
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}

class CongratulationCenter extends StatelessWidget {
  const CongratulationCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Image.asset(
            'assets/images/congratulation.png',
            height: 120,
            width: 120,
          ),
          const SizedBox(height: 20),
          Text(
            'Congratulations !',
            style: TextStyle(
              color: Colors.blueGrey[600],
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: Get.mediaQuery.size.width * 0.5,
            child: Text(
              'You have finished your fasting goal',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blueGrey[600],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CountDownCenter extends StatelessWidget {
  CountDownCenter({
    super.key,
    required this.controller,
    required this.countText,
    required this.stopProgress,
    required this.duration,
    required this.progress,
    required this.isPlay,
  });
  final fastingPlanController = Get.find<FastingPlanController>();
  final AnimationController? controller;
  final String countText;
  final Function() stopProgress;
  final Duration duration;
  final double progress;
  final bool isPlay;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          radius: 40,
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            fastingPlanController.isRemainMode.value =
                !fastingPlanController.isRemainMode.value;
          },
          child: Icon(
            Icons.change_circle_rounded,
            color: Colors.blue[300],
            size: 35,
          ),
        ),
        Text(
          fastingPlanController.isRemainMode.value
              ? 'Remaining'
              : 'Fasting Time',
          style: TextStyle(
            color: Colors.blueGrey[600],
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        AnimatedBuilder(
          animation: controller!,
          builder: (context, child) => Text(
            countText,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            if (isPlay) {
              controller!.stop();
            } else {
              controller!.forward(from: controller!.value);
            }
            stopProgress();
          },
          radius: 60,
          child: Icon(
            isPlay
                ? Icons.pause_circle_filled_rounded
                : Icons.play_circle_fill_rounded,
            color: Colors.blue[300],
            size: 45,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'End Time',
          style: TextStyle(
            color: Colors.blueGrey[600],
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        Obx(
          () => Text(
            DateFormat().add_jm().format(
                  fastingPlanController.chooseDateTime.value.add(duration),
                ),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          width: 100,
          child: Divider(
            thickness: 1,
          ),
        ),
        Text(
          '${(progress * 100).toInt()}%',
          style: const TextStyle(
            color: Colors.blueGrey,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

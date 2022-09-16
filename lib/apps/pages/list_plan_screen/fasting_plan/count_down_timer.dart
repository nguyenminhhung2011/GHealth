import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/fasting_plan_controller.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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

  var isPlay = false.obs;
  var isFinish = false.obs;
  var progress = 0.00.obs;

  void stopProgress() {
    isPlay.value = !isPlay.value;
  }

  String get countText {
    Duration count = fastingPlanController.controllerCountDown!.duration! *
        fastingPlanController.controllerCountDown!.value;
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
      fastingPlanController.controllerCountDown =
          AnimationController(vsync: this, duration: widget.duration);

      if (fastingPlanController.fasting.isSaving) {
        int? remainingTime;

        if (fastingPlanController.fasting.isPlaying) {
          remainingTime =
              (fastingPlanController.fasting.timeRemaining.inSeconds +
                  DateTime.now()
                      .difference(fastingPlanController.fasting.saveTime)
                      .inSeconds);
        } else {
          remainingTime = fastingPlanController.fasting.timeRemaining.inSeconds;
        }
        fastingPlanController.controllerCountDown!.value =
            (fastingPlanController.fasting.timeRemaining.inSeconds +
                    fastingPlanController.fasting.saveTime
                        .difference(fastingPlanController.fasting.startTime)
                        .inSeconds) /
                widget.duration.inSeconds;

        fastingPlanController.controllerCountDown!.value =
            remainingTime / widget.duration.inSeconds;
      }
      fastingPlanController.controllerCountDown!.addListener(() {
        progress.value = fastingPlanController.controllerCountDown!.value;
        if (fastingPlanController.controllerCountDown!.isCompleted) {
          fastingPlanController.controllerCountDown!.stop();
          isFinish.value = true;
          _controllerOpacity.forward();
          isPlay.value = false;
        }
      });
      isPlay.value = fastingPlanController.fasting.isPlaying;
      if (isPlay.value) {
        fastingPlanController.controllerCountDown!.forward();
      }
    });
    return true;
  }

  @override
  void dispose() async {
    if (!fastingPlanController.isEnding) {
      // DateTime time = DateTime.now().add(widget.duration);
      // createFastingNotificationAuto(NotificationCalendar.fromDate(
      //   date: time,
      // ));
      FastingHistory newValue = FastingHistory(
        endTime: fastingPlanController.fasting.endTime,
        isFinish: false,
        name: fastingPlanController.fasting.name,
        startTime: fastingPlanController.fasting.startTime,
        isPlaying: isPlay.value,
        isSaving: true,
        saveTime: DateTime.now(),
        timeRemaining: fastingPlanController.controllerCountDown!.duration! *
            fastingPlanController.controllerCountDown!.value,
      );
      fastingPlanController.updateHistory(
          fastingPlanController.idFasting, newValue);
    }
    _controllerOpacity.dispose();
    fastingPlanController.controllerCountDown!.dispose();
    fastingPlanController.controllerCountDown = null;
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
                                    controller: fastingPlanController
                                        .controllerCountDown,
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

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
  late AnimationController _controller;

  var isPlay = false.obs;
  var isFinish = false.obs;
  double progress = 0;
  String get countText {
    Duration count = _controller.duration! * _controller.value;
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
        vsync: this, duration: const Duration(milliseconds: 600));
    _animationOpacity = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controllerOpacity, curve: Curves.easeIn));
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _controller.addListener(() {
      setState(() {
        progress = _controller.value;
      });
      if (_controller.isCompleted) {
        _controller.stop();
        isFinish.value = true;
        _controllerOpacity.forward();
        isPlay.value = false;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => CircularPercentIndicator(
            center: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: isFinish.value
                  ? FadeTransition(
                      opacity: _animationOpacity,
                      child: congratulationCenter(),
                    )
                  : countDownCenter(),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            percent: fastingPlanController.isRemainMode.value
                ? 1 - progress
                : progress,
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

  Widget countDownCenter() {
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
          animation: _controller,
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
            if (isPlay.value) {
              _controller.stop();
            } else {
              _controller.forward(from: _controller.value);
            }
            isPlay.value = !isPlay.value;
          },
          radius: 60,
          child: Obx(() => Icon(
                isPlay.value
                    ? Icons.pause_circle_filled_rounded
                    : Icons.play_circle_fill_rounded,
                color: Colors.blue[300],
                size: 45,
              )),
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
              DateFormat().add_jm().format(fastingPlanController
                  .chooseDateTime.value
                  .add(widget.duration)),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
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

  Widget congratulationCenter() {
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

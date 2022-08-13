import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  late AnimationController _controller;
  var remainMode = false.obs;
  var isPlay = false.obs;
  double progress = 0;
  DateTime now = DateTime.now();
  String get countText {
    DateTime finish = now.add(widget.duration);

    Duration count = _controller.duration! * _controller.value;
    if (remainMode.value) {
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
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.addListener(() {
      setState(() {
        progress = _controller.value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => CircularPercentIndicator(
            center: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  InkWell(
                    radius: 40,
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      remainMode.value = !remainMode.value;
                    },
                    child: Icon(
                      Icons.change_circle_rounded,
                      color: Colors.blue[300],
                      size: 35,
                    ),
                  ),
                  Text(
                    remainMode.value ? 'Remaining' : 'Fasting Time',
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
                  Text(
                    DateFormat().add_jm().format(now.add(widget.duration)),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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
              ),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            percent: remainMode.value ? 1 - progress : progress,
            reverse: remainMode.value,
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

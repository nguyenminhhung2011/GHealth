import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../template/misc/colors.dart';

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
  final int? isReady;
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
      if (widget.isReady == 1) {
        _controllerCurrentTime!.stop();
        _controllerCurrentTime =
            AnimationController(vsync: this, duration: widget.currentTime);
        _controllerCurrentTime!.forward(from: _controllerCurrentTime!.value);
      } else if (widget.isReady == -1) {
        _controllerCurrentTime!.stop();
        _controllerCurrentTime =
            AnimationController(vsync: this, duration: widget.currentReadyTime);
        _controllerCurrentTime!.forward(from: _controllerCurrentTime!.value);
      } else if (widget.isReady == 0) {
        _controllerCurrentTime!.stop();
      }
      if (widget.isReady != 0) {
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
                  (widget.isReady == 1) ? 'Ready' : 'Workout',
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

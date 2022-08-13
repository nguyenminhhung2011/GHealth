import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TimeCustom extends StatefulWidget {
  final Color fillColor;
  final Color backGroundColor;
  final VoidCallback oncomplete;
  final VoidCallback onStart;
  final int duration;
  final int initiaDuration;
  final double width;
  final double height;
  final double strokeCircle;
  final StrokeCap strokeCap;
  final bool isReverse;
  final bool isReverseAnimation;
  final bool isTimerTextShown;
  final bool autoStart;
  final Widget? childWidget;
  final double indicatorWidth;
  final Color indicatorColor;
  final CountDownController? controller;
  const TimeCustom({
    Key? key,
    required this.fillColor,
    required this.backGroundColor,
    required this.oncomplete,
    required this.onStart,
    required this.duration,
    required this.initiaDuration,
    required this.width,
    required this.strokeCircle,
    required this.strokeCap,
    required this.isReverse,
    required this.isReverseAnimation,
    required this.isTimerTextShown,
    required this.autoStart,
    this.childWidget,
    required this.indicatorWidth,
    required this.indicatorColor,
    this.controller,
    required this.height,
  }) : super(key: key);

  @override
  TimeCustomState createState() => TimeCustomState();
}

class TimeCustomState extends State<TimeCustom> with TickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? countDownAnimation;

  void setAnimation() {
    if (widget.autoStart) {
      widget.isReverse ? controller!.reverse(from: 1) : controller!.forward();
    }
  }

  void setAnimationDirection() {
    if ((!widget.isReverse && widget.isReverseAnimation) ||
        (widget.isReverse && !widget.isReverseAnimation)) {
      countDownAnimation = Tween<double>(begin: 1, end: 0).animate(controller!);
    }
  }

  void setController() {
    widget.controller?.state = this;
    widget.controller?.isReverse = widget.isReverse;
    widget.controller?.initalDuration = widget.initiaDuration;
    widget.controller?.duration = widget.duration;

    if (widget.initiaDuration > 0 && widget.autoStart) {
      widget.isReverse
          ? controller?.value = 1 - (widget.initiaDuration / widget.duration)
          : controller?.value = (widget.initiaDuration / widget.duration);
      widget.controller!.start();
    }
  }

  void onStart() {
    if (widget.onStart != null) {
      widget.onStart();
    }
  }

  void onComplete() {
    if (widget.oncomplete != null) {
      widget.oncomplete();
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    );
    controller!.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.forward:
          onStart();
          break;
        case AnimationStatus.reverse:
          onStart();
          break;
        case AnimationStatus.dismissed:
          onComplete();
          break;
        case AnimationStatus.completed:
          if (!widget.isReverse) onComplete();
          break;
        default:
          break;
      }
    });
    setAnimation();
    setAnimationDirection();
    setController();
  }

  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
    );
  }
}

class CountDownController {
  late TimeCustomState state;
  late bool isReverse;
  int? initalDuration, duration;

  void start() {
    (isReverse)
        ? state.controller?.reverse(
            from: initalDuration == 0 ? 1 : 1 - (initalDuration! / duration!))
        : state.controller?.forward(
            from: initalDuration == 0 ? 0 : (initalDuration! / duration!));
  }

  void pause() {
    state.controller!.stop(canceled: false);
  }

  void reset() {
    (isReverse)
        ? state.controller?.reverse(from: 0)
        : state.controller?.forward(from: 1);
    pause();
  }
}

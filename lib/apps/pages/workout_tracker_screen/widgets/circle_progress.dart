import 'dart:math';

import 'package:flutter/material.dart';

import '../../../template/misc/colors.dart';

class CircleProgress extends CustomPainter {
  final double strokeCircle;
  final double currentProgress;
  final double parentProgress;
  final double radius;
  final Color fillColor;
  final Color backGroundColor;
  CircleProgress(
    this.currentProgress,
    this.parentProgress,
    this.radius,
    this.strokeCircle,
    this.fillColor,
    this.backGroundColor,
  );
  @override
  void paint(Canvas canvas, Size size) {
    // Draw Circle
    Paint circle = Paint()
      ..strokeWidth = strokeCircle
      ..color = backGroundColor
      ..style = PaintingStyle.stroke;
    Offset center = Offset(size.width / 2, size.width / 2);
    canvas.drawCircle(center, radius, circle);
    //Draw animation
    Paint animationArc = Paint()
      ..strokeWidth = strokeCircle
      ..color = fillColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    double angle = 2 * pi * (currentProgress / parentProgress);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), pi / 2,
        angle, false, animationArc);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

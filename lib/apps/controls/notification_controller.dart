import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NotificationController extends GetxController {
  Map<DateTime, Map<String, dynamic>> notifications = {
    DateTime.now().subtract(const Duration(minutes: 5)): {
      'icon': Image.asset(
        'assets/icons/cake_2.png',
      ),
      'title': 'Hey, it\'s time for lunch',
    },
    DateTime.now().subtract(const Duration(hours: 2)): {
      'icon': Image.asset(
        'assets/icons/woman_workout.png',
      ),
      'title': 'Don\'t miss your abs workout',
    },
    DateTime.now().subtract(const Duration(hours: 6)): {
      'icon': Image.asset(
        'assets/icons/cake.png',
      ),
      'title': 'Hey, let\'t add some meal for your body',
    },
    DateTime.now().subtract(const Duration(days: 10)): {
      'icon': Image.asset(
        'assets/icons/man_workout.png',
      ),
      'title': 'Congratulation, you have finished your workout',
    },
    DateTime.now().subtract(const Duration(days: 50)): {
      'icon': Image.asset(
        'assets/icons/cake.png',
      ),
      'title': 'Hey, it\'s time for lunch',
    },
    DateTime.now().subtract(const Duration(days: 100)): {
      'icon': Image.asset(
        'assets/icons/cake.png',
      ),
      'title': 'Ups, You have missed your lowerbody workout',
    },
  }.obs;

  bool get isEmptyNotify {
    if (notifications.isEmpty) return true;
    return false;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gold_health/services/notification.dart';

import '../../constrains.dart';
import '../../services/auth_service.dart';
import '../template/misc/untils.dart';

class DashBoardControl extends GetxController {
  var tabIndex = 0.obs;
  var pageController = PageController();

  createAllNotification() async {
    cancelScheduledNotifications().then((value) async {
      QuerySnapshot<Map<String, dynamic>> raw = await firestore
          .collection('users')
          .doc(AuthService.instance.currentUser!.uid)
          .collection('timeEat')
          .get();
      Map<String, dynamic> listTime = raw.docs[0].data();
      int countingCheck = 1;
      for (var item in listTime['list']) {
        DateTime date =
            DateTime.fromMillisecondsSinceEpoch(item.seconds * 1000);
        for (int i = 1; i <= 7; i++) {
          createMealNotificationAuto(
              NotificationWeekAndTime(
                dayOfTheWeek: i,
                timeOfDay: TimeOfDay(hour: date.hour, minute: date.minute),
              ),
              countingCheck + 1);
        }
        countingCheck;
      }
      QuerySnapshot<Map<String, dynamic>> rawSleep = await firestore
          .collection('users')
          .doc(AuthService.instance.currentUser!.uid)
          .collection('sleep_basic_time')
          .doc('sleep')
          .collection('sleep_time')
          .get();
      for (var item in rawSleep.docs) {
        DateTime timeBed = DateTime.fromMillisecondsSinceEpoch(
            item.data()['bedTime'].seconds * 1000);
        DateTime timeAlarm = DateTime.fromMillisecondsSinceEpoch(
            item.data()['alarm'].seconds * 1000);
        for (var ite in item.data()['listDate']) {
          createSleepNotificationAuto(
            NotificationWeekAndTime(
              dayOfTheWeek: ite,
              // timeOfDay: TimeOfDay(hour: timeBed.hour, minute: timeBed.minute),
              timeOfDay: TimeOfDay(
                  hour: DateTime.now().hour, minute: DateTime.now().minute + 1),
            ),
          );
        }
      }
    });
  }

  @override
  void onInit() async {
    super.onInit();
    tabIndex.value = 0;
    await createAllNotification();
  }

  @override
  void onClose() {
    tabIndex.value = 0;
    super.onClose();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gold_health/main.dart';
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
      for (var item in listTime['list']) {
        DateTime date =
            DateTime.fromMillisecondsSinceEpoch(item.seconds * 1000);
        for (int i = 1; i <= 7; i++) {
          createMealNotificationAuto(
              NotificationWeekAndTime(
                dayOfTheWeek: i,
                timeOfDay: TimeOfDay(hour: date.hour, minute: date.minute),
              ),
              3);
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gold_health/services/notification.dart';

import '../../constrains.dart';
import '../../services/auth_service.dart';
import '../../services/data_service.dart';
import '../template/misc/untils.dart';

class DashBoardControl extends GetxController {
  var tabIndex = 0.obs;
  var pageController = PageController();
  static DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  createAllNotification() async {
    var raw = await firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('notification')
        .get();
    // bool dCheck = raw.docs[0].data()['fCheck'];
    List<String> listDevice =
        List<String>.from(raw.docs[0].data()['list_service']);
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    bool check = listDevice.contains(androidInfo.model);
    print(listDevice);
    listDevice.add(androidInfo.model!);
    print('Android Device');
    print(androidInfo.model! + '------------');
    DataService.instance.clearListNotification();
    DataService.instance.checkIdNoti.value = 1;

    if (!check) {
      await firestore
          .collection('users')
          .doc(AuthService.instance.currentUser!.uid)
          .collection('notification')
          .doc(raw.docs[0].id)
          .update(
        {'list_service': listDevice},
      ).then((value) {
        print('Update notification');
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
                  countingCheck);
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
            DataService.instance.initIdNotificationMap(item.id);
            print(item.id);
            for (var ite in item.data()['listDate']) {
              List<int> id =
                  DataService.instance.addDataToListNotification(item.id);
              print(id);
              createSleepNotificationAuto(
                NotificationWeekAndTime(
                  dayOfTheWeek: ite,
                  timeOfDay:
                      TimeOfDay(hour: timeBed.hour, minute: timeBed.minute),
                ),
                id[0],
              );
              createAlarmNotificationAuto(
                NotificationWeekAndTime(
                  dayOfTheWeek: ite,
                  timeOfDay:
                      TimeOfDay(hour: timeAlarm.hour, minute: timeAlarm.minute),
                ),
                id[1],
              );
            }
          }
          print('List Notification =========');
          print(DataService.instance.listIdNotificationSleep);
        });
      });
    }
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

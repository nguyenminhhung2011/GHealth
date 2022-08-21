import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/auth_controller.dart';
import 'package:gold_health/constains.dart';

import '../../services/auth_service.dart';

class HomeScreenControl extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;
  final Rx<String> _uid = "".obs;
  var notifications = {
    DateTime.now().subtract(const Duration(minutes: 5)): {
      'icon': CircleAvatar(
        child: Image.asset(
          'assets/icons/Ellipse.png',
        ),
      ),
      'title': 'Hey, it\'s time for lunch',
    },
    DateTime.now().subtract(const Duration(hours: 2)): {
      'icon': Image.asset(
        'assets/icons/Ellipse (3).png',
      ),
      'title': 'Don\'t miss your abs workout',
    },
    DateTime.now().subtract(const Duration(hours: 6)): {
      'icon': Image.asset(
        'assets/icons/Ellipse (2).png',
      ),
      'title': 'Hey, let\'t add some meal for your body',
    },
    DateTime.now().subtract(const Duration(days: 10)): {
      'icon': Image.asset(
        'assets/icons/Ellipse (3).png',
      ),
      'title': 'Congratulation, you have finished your workout',
    },
    DateTime.now().subtract(const Duration(days: 50)): {
      'icon': Image.asset(
        'assets/icons/Ellipse (2).png',
      ),
      'title': 'Hey, it\'s time for lunch',
    },
    DateTime.now().subtract(const Duration(days: 100)): {
      'icon': Image.asset(
        'assets/icons/Ellipse.png',
      ),
      'title': 'Ups, You have missed your lowerbody workout',
    },
  }.obs;

  bool get isNotify {
    if (notifications.isEmpty) return false;
    return true;
  }

  void deleteNotification(DateTime key) {
    notifications.remove(key);
    if (notifications.values.isEmpty) {
      notifications.refresh();
    }
  }

  @override
  void onInit() {
    super.onInit();
    updateUser(AuthService.instance.currentUser!.uid);
    //ignore: avoid_print
    print(_user.value['uid']);
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Get user from firestore
  updateUser(String id) {
    _uid.value = id;
    getDataUser(_uid.value);
  }

  getDataUser(String uid) async {
    var userDoc = await firestore.collection('users').doc(uid).get();
    Map<String, dynamic> result = (userDoc.data() as Map<String, dynamic>);
    _user.value = result;
    //print(result['name'] + ' and ' + _user.value['name']);
    update();
  }
}

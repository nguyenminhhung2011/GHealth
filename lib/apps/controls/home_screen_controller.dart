import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        child: SvgPicture.asset(
          'assets/icons/cake_2.svg',
        ),
      ),
      'title': 'Hey, it\'s time for lunch',
    },
    DateTime.now().subtract(const Duration(hours: 2)): {
      'icon': CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 230, 211, 233),
        child: SvgPicture.asset(
          'assets/icons/woman_workout.svg',
        ),
      ),
      'title': 'Don\'t miss your abs workout',
    },
    DateTime.now().subtract(const Duration(hours: 6)): {
      'icon': CircleAvatar(
        child: SvgPicture.asset(
          'assets/icons/cake.svg',
        ),
      ),
      'title': 'Hey, let\'t add some meal for your body',
    },
    DateTime.now().subtract(const Duration(days: 10)): {
      'icon': CircleAvatar(
        child: SvgPicture.asset(
          'assets/icons/man_workout.svg',
        ),
      ),
      'title': 'Congratulation, you have finished your workout',
    },
    DateTime.now().subtract(const Duration(days: 50)): {
      'icon': CircleAvatar(
        child: SvgPicture.asset(
          'assets/icons/cake.svg',
        ),
      ),
      'title': 'Hey, it\'s time for lunch',
    },
    DateTime.now().subtract(const Duration(days: 100)): {
      'icon': CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 230, 211, 233),
        child: SvgPicture.asset(
          'assets/icons/cake.svg',
        ),
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
  // ignore: unnecessary_overrides
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

  double bmi() {
    return (_user.value != null)
        ? (_user.value['weight'] /
            ((_user.value['height'] / 100) * (_user.value['height'] / 100)))
        : 38.0;
  }
}

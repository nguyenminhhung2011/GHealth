import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/auth_controller.dart';
import 'package:gold_health/constains.dart';

class HomeScreenControl extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

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
    getUser();
    //ignore: avoid_print
    print(_user.value['name']);
    super.onInit();
  }

  @override
  // ignore: unnecessary_overrides
  void onClose() {
    super.onClose();
  }

  Future<Map<String, dynamic>> getDataUser(String uid) async {
    var userDoc = await firestore.collection('users').doc(uid).get();
    Map<String, dynamic> result = (userDoc.data() as Map<String, dynamic>);
    return result;
  }

  getUser() async {
    //ignore: avoid_print
    print(firebaseAuth.currentUser!.uid);

    _user.value = await getDataUser(firebaseAuth.currentUser!.uid);
    update();
  }
}

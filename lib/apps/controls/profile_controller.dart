import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/auth_controller.dart';
import 'package:gold_health/constains.dart';
import 'package:age/age.dart';

import '../../services/auth_service.dart';

class ProfileC extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;
  final Rx<String> _uid = "".obs;

  AgeDuration get getAge {
    DateTime birthday = DateTime.fromMillisecondsSinceEpoch(
        _user.value['dateOfBirth'].seconds * 1000);
    DateTime today = DateTime.now();
    AgeDuration age;

    // Find out your age
    age = Age.dateDifference(
        fromDate: birthday, toDate: today, includeToDate: false);
    return age;
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
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/auth_controller.dart';
import 'package:gold_health/constains.dart';

class ActivityTrackerC extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  @override
  void onInit() {
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

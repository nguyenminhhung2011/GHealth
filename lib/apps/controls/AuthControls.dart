import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gold_health/constains.dart';

import '../data/models/User.dart';

class AuthC extends GetxController {
  static AuthC instance = Get.find();
  final _fireStore = FirebaseFirestore.instance;
  late Rx<User?> _user;
  User get user => _user.value!;
  @override
  void onReady() {
    super.onReady();
  }
}

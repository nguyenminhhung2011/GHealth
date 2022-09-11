import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import '../apps/controls/auth_controller.dart';

class StartService {
  StartService._privateConstructor();
  static final StartService instance = StartService._privateConstructor();
  init() async {
    await Firebase.initializeApp();
  }
}

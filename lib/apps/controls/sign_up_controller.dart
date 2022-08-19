import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/global_widgets/dialog/error_dialog.dart';

import '../data/enums/app_enums.dart';
import '../data/models/User.dart';
import '../routes/route_name.dart';
import 'auth_controller.dart';

class SignUpC extends GetxController {
  late TextEditingController emailC;
  late TextEditingController passC;
  late TextEditingController repassC;
  RxString gifString = 'assets/gift/download.gif'.obs;

  Rx<User>? basicProfile = Rx<User>(
    User(
      uid: '',
      name: '',
      username: '',
      password: '',
      height: 0,
      weight: 0,
      heightTarget: 0,
      weightTarget: 0,
      dateOfBirth: DateTime.now(),
      gender: Gender.male,
      duration: Times.medium,
      avtPath: '',
    ),
  );
  late Uint8List image;
  @override
  void onInit() {
    super.onInit();
    emailC = TextEditingController();
    passC = TextEditingController();
    repassC = TextEditingController();
    emailC.text = 'h@gmail.com';
    passC.text = '1234567';
    repassC.text = '1234567';
  }

  @override
  void onClose() {
    super.onClose();
  }

  void ContinueBtnClick() {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(emailC.text);
      if (emailValid) {
        if (passC.text.length > 6) {
          if (passC.text == repassC.text) {
            basicProfile!.value.username = emailC.text;
            basicProfile!.value.password = passC.text;
            // ignore: avoid_print
            print('success');
            Get.toNamed(RouteName.basicInfoScreen);
          } else {
            //ignore: avoid_print
            Get.dialog(const ErrorDialog(
              question: 'Error Create Account',
              title1: 'RePass is invalid',
            ));
          }
        } else {
          Get.dialog(const ErrorDialog(
            question: 'Error Create Account',
            title1: 'Your password is too short',
          ));
        }
      } else {
        Get.dialog(const ErrorDialog(
          question: 'Error Create Account',
          title1: 'Email is not format',
        ));
        return;
      }
    } else {
      Get.dialog(const ErrorDialog(
        question: 'Error Create Account',
        title1: 'Field is not null',
      ));
      return;
    }
  }
}

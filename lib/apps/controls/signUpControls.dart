import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/enums/app_enums.dart';
import '../data/models/User.dart';
import '../routes/routeName.dart';
import 'AuthControls.dart';

class SignUpC extends GetxController {
  late TextEditingController emailC;
  late TextEditingController passC;
  late TextEditingController repassC;
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
    emailC.dispose();
    passC.dispose();
    repassC.dispose();

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
            Get.toNamed(RouteName.fillProfile);
          } else {
            //ignore: avoid_print
            print('Repass is invalid');
          }
        } else {
          // ignore: avoid_print
          print('Your password is too short');
        }
      } else {
        // ignore: avoid_print
        print('Email is not format');
        return;
      }
    } else {
      //ignore: avoid_print
      print('Field is not null');
      return;
    }
  }
}

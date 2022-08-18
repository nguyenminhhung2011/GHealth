import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/auth_controller.dart';
import 'package:gold_health/apps/controls/sign_up_controller.dart';
import 'package:gold_health/apps/global_widgets/dialog/yes_no_dialog.dart';
import 'package:gold_health/constains.dart';
import 'package:intl/intl.dart';

import '../data/enums/app_enums.dart';
import 'basic_info_controller.dart';

class SelectDurationC extends GetxController {
  late Rx<Times> duration = Times.little.obs; // -1 female 0 none 1 male
  final basicInfoC = Get.find<BasicInfoC>();
  @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onClose() {
    duration.value = Times.little;
    super.onClose();
  }

  void nextBtnClick() {
    if (duration.value != null) {
      basicInfoC.signUpC.basicProfile!.value.duration = duration.value;
      Get.dialog(
        YesNoDialog(
          press: () async {
            String result = await AuthC().signUp(
              name: basicInfoC.signUpC.basicProfile!.value.name,
              username: basicInfoC.signUpC.basicProfile!.value.username,
              password: basicInfoC.signUpC.basicProfile!.value.password,
              height: basicInfoC.signUpC.basicProfile!.value.height,
              weight: basicInfoC.signUpC.basicProfile!.value.weight,
              heightTarget: 22,
              weightTarget: 33,
              dateOfBirth: basicInfoC.signUpC.basicProfile!.value.dateOfBirth,
              gender: basicInfoC.signUpC.basicProfile!.value.gender,
              duration: basicInfoC.signUpC.basicProfile!.value.duration,
              image: basicInfoC.signUpC.image,
            );
            //ignore: avoid_print
            print(result);
            if (result == "Create account is success") {
              await firebaseAuth.signInWithEmailAndPassword(
                  email: basicInfoC.signUpC.basicProfile!.value.username,
                  password: basicInfoC.signUpC.basicProfile!.value.password);

              Get.find<AuthC>();
            }
          },
          question: 'Confirm Information',
          title1:
              'Name: ${basicInfoC.signUpC.basicProfile!.value.name}\nDate of birth: ${DateFormat.yMd().format(basicInfoC.signUpC.basicProfile!.value.dateOfBirth)} \n',
          title2:
              'Current Height: ${basicInfoC.signUpC.basicProfile!.value.height}\nCurrent Weight: ${basicInfoC.signUpC.basicProfile!.value.weight}\nDuration: ${listTimesString[basicInfoC.signUpC.basicProfile!.value.duration]}',
        ),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/AuthControls.dart';
import 'package:gold_health/apps/controls/signUpControls.dart';
import 'package:gold_health/apps/global_widgets/yes_no_dialog.dart';
import 'package:intl/intl.dart';

import '../data/enums/app_enums.dart';

class SelectDurationC extends GetxController {
  late Rx<Times> duration = Times.little.obs; // -1 female 0 none 1 male
  final signUpC = Get.find<SignUpC>();
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
      signUpC.basicProfile!.value.duration = duration.value;
      Get.dialog(
        YesNoDialog(
          press: () async {
            String reseult = await AuthC().SignUp(
              name: signUpC.basicProfile!.value.name,
              username: signUpC.basicProfile!.value.username,
              password: signUpC.basicProfile!.value.password,
              height: signUpC.basicProfile!.value.height,
              weight: signUpC.basicProfile!.value.weight,
              heightTarget: 22,
              weightTarget: 33,
              dateOfBirth: signUpC.basicProfile!.value.dateOfBirth,
              gender: signUpC.basicProfile!.value.gender,
              duration: signUpC.basicProfile!.value.duration,
              image: signUpC.image,
            );
            print(reseult);
          },
          question: 'Confirm Information',
          title1:
              'Name: ${signUpC.basicProfile!.value.username}\nDate of birth: ${DateFormat.yMd().format(signUpC.basicProfile!.value.dateOfBirth)} \n',
          title2:
              'Current Height: ${signUpC.basicProfile!.value.height}\nCurrent Weight: ${signUpC.basicProfile!.value.weight}\nDuration: ${listTimesString[signUpC.basicProfile!.value.duration]}',
        ),
      );
    }
  }
}

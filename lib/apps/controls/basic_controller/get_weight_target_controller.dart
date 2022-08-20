import 'package:get/get.dart';
import 'package:gold_health/apps/controls/sign_up_controller.dart';
import 'package:gold_health/apps/global_widgets/dialog/choose_options_dialog.dart';
import 'package:intl/intl.dart';

import '../../../constains.dart';
import '../../data/enums/app_enums.dart';
import '../../global_widgets/dialog/yes_no_dialog.dart';
import '../../routes/route_name.dart';
import '../../template/misc/colors.dart';
import '../auth_controller.dart';
import 'basic_controller.dart';

class GetWeightTargetC extends GetxController with BasicController {
  RxInt weight = 1.obs;
  final signUpC = Get.find<SignUpC>();
  final authC = Get.find<AuthC>();
  final RxBool creatResult = false.obs;
  var list = [for (var i = 1; i <= 200; i++) i];
  @override
  // void OnInit() {
  //   super.onInit();
  // }

  void nextBtnClick() async {
    signUpC.basicProfile!.value.weightTarget = weight.value;
    creatResult.value = await Get.dialog(
      YesNoDialog(
        press: () async {
          String create = await authC.signUp(
            name: signUpC.basicProfile!.value.name,
            username: signUpC.basicProfile!.value.username,
            password: signUpC.basicProfile!.value.password,
            height: signUpC.basicProfile!.value.height,
            weight: signUpC.basicProfile!.value.weight,
            heightTarget: signUpC.basicProfile!.value.heightTarget,
            weightTarget: signUpC.basicProfile!.value.weightTarget,
            dateOfBirth: signUpC.basicProfile!.value.dateOfBirth,
            gender: signUpC.basicProfile!.value.gender,
            duration: signUpC.basicProfile!.value.duration,
            image: signUpC.image,
          );
          //ignore: avoid_print
          print(create);
          if (create == "Create account is success") {
            Get.dialog(
              ChooseOptionsDialog(
                press1: () {
                  authC.signOut();
                },
                question:
                    'Do you want to go to Home Screen or go back to login?',
                title1: 'Login',
                title2: 'Home Screen',
                press2: () {
                  Get.offAllNamed(authC.initialPage);
                },
              ),
            );
          } else {}
        },
        question: 'Confirm Information',
        title1:
            'Name: ${signUpC.basicProfile!.value.name}\nDate of birth: ${DateFormat.yMd().format(signUpC.basicProfile!.value.dateOfBirth)} \n',
        title2:
            'Current Height: ${signUpC.basicProfile!.value.height}\nCurrent Weight: ${signUpC.basicProfile!.value.weight}\nDuration: ${listTimesString[signUpC.basicProfile!.value.duration]}',
      ),
    );
    print(creatResult.value);
    if (creatResult.value == true) {}
  }
}

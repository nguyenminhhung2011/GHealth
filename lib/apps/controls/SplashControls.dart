import 'package:get/get.dart';
import 'package:gold_health/apps/controls/AuthControls.dart';
import 'package:gold_health/apps/pages/IntroListScreen/intro1Screen.dart';
import 'package:gold_health/apps/routes/routeName.dart';
import 'package:gold_health/constains.dart';
import 'package:gold_health/services/startServices.dart';

class SplashC extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    StartService.instance.init();
    await Future.delayed(const Duration(seconds: 3), () {});
    await GotoNextScreen();
  }

  Future<void> GotoNextScreen() async {
    if (AuthC.instance.user != null) {
    } else {
      Get.offAllNamed(RouteName.logIn);
    }
  }
}

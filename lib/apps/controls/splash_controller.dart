import 'package:get/get.dart';
import 'package:gold_health/apps/controls/auth_controller.dart';
import 'package:gold_health/apps/pages/IntroListScreen/intro_screen.dart';
import 'package:gold_health/apps/routes/route_name.dart';
import 'package:gold_health/constains.dart';
import 'package:gold_health/services/start_services.dart';

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
      Get.toNamed(RouteName.dashboardScreen);
    } else {
      Get.offAllNamed(RouteName.logIn);
    }
  }
}

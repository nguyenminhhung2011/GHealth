import 'package:get/get_navigation/get_navigation.dart';
import 'package:gold_health/apps/binding/splashBinding.dart';
import 'package:gold_health/apps/pages/IntroListScreen/intro1Screen.dart';
import 'package:gold_health/apps/pages/IntroListScreen/splashScreen.dart';
import 'package:gold_health/apps/pages/LogInScreen/LogInScreen.dart';
import 'package:gold_health/apps/routes/routeName.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: RouteName.splash,
      page: () => SplashCreen(),
      binding: SplashB(),
    ),
    GetPage(
      name: RouteName.intro,
      page: () => IntroScreen(),
    ),
    GetPage(
      name: RouteName.logIn,
      page: () => LogInScreen(),
    ),
  ];
}

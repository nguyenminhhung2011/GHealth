import 'package:get/get_navigation/get_navigation.dart';
import 'package:gold_health/apps/binding/loginBinding.dart';
import 'package:gold_health/apps/binding/select_durationBinding.dart';
import 'package:gold_health/apps/binding/select_genderBinding.dart';
import 'package:gold_health/apps/binding/splashBinding.dart';
import 'package:gold_health/apps/pages/IntroListScreen/introScreen.dart';
import 'package:gold_health/apps/pages/IntroListScreen/splashScreen.dart';
import 'package:gold_health/apps/pages/LogInScreen/LogInScreen.dart';
import 'package:gold_health/apps/pages/LogInScreen/signUpScreen.dart';
import 'package:gold_health/apps/pages/basic_info_screen/get_weight_screen.dart';
import 'package:gold_health/apps/pages/basic_info_screen/select_duration_screen.dart';
import 'package:gold_health/apps/routes/routeName.dart';

import '../binding/signUpBinding.dart';
import '../pages/basic_info_screen/get_height_screen.dart';
import '../pages/basic_info_screen/get_old_screen.dart';
import '../pages/basic_info_screen/select_gender_screen.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: RouteName.splash,
      page: () => SplashScreen(),
      binding: SplashB(),
    ),
    GetPage(
      name: RouteName.intro,
      page: () => IntroScreen(),
    ),
    GetPage(
      name: RouteName.logIn,
      page: () => LogInScreen(),
      binding: LogInB(),
    ),
    GetPage(
      name: RouteName.signUp,
      page: () => SignUpScreen(),
      binding: SignUpB(),
    ),
    GetPage(
      name: RouteName.selectGender,
      page: () => SelectGenderScreen(),
      binding: SelectGenderB(),
    ),
    GetPage(
      name: RouteName.selectDuration,
      page: () => SelectDurationScreen(),
      binding: SelectDurationB(),
    ),
    GetPage(
      name: RouteName.getOld,
      page: () => GetOldScreen(),
    ),
    GetPage(
      name: RouteName.getWeight,
      page: () => GetWeightScreen(),
    ),
    GetPage(
      name: RouteName.getHeight,
      page: () => GetHeightScreen(),
    )
  ];
}

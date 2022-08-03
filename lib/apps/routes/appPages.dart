import 'package:get/get_navigation/get_navigation.dart';
import 'package:gold_health/apps/binding/fillProfileBinding.dart';
import 'package:gold_health/apps/binding/loginBinding.dart';
import 'package:gold_health/apps/binding/select_durationBinding.dart';
import 'package:gold_health/apps/binding/select_genderBinding.dart';
import 'package:gold_health/apps/binding/splashBinding.dart';
import 'package:gold_health/apps/binding/home_screen_binding.dart';
import 'package:gold_health/apps/binding/dashboard_binding.dart';

import 'package:gold_health/apps/pages/IntroListScreen/introScreen.dart';
import 'package:gold_health/apps/pages/IntroListScreen/splashScreen.dart';
import 'package:gold_health/apps/pages/LogInScreen/LogInScreen.dart';
import 'package:gold_health/apps/pages/LogInScreen/signUpScreen.dart';
import 'package:gold_health/apps/pages/basic_info_screen/get_weight_screen.dart';
import 'package:gold_health/apps/pages/basic_info_screen/select_duration_screen.dart';
import 'package:gold_health/apps/pages/dashboard/dashboard_screen.dart';
import 'package:gold_health/apps/pages/dashboard/home_screen.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/workout_schedule_screen.dart';
import 'package:gold_health/apps/routes/routeName.dart';
import 'package:gold_health/apps/pages/dashboard/activity_trackerScreen.dart';
import '../pages/dashboard/notification_screen.dart';
// import '../binding/notification_binding.dart';

import '../binding/dashboard_binding.dart';
import '../binding/signUpBinding.dart';
import '../pages/basic_info_screen/fillProfile.dart';
import '../pages/basic_info_screen/get_height_screen.dart';
import '../pages/basic_info_screen/get_old_screen.dart';
import '../pages/basic_info_screen/select_gender_screen.dart';
import '../pages/dashboard/home_screen.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: RouteName.splash,
      page: () => const SplashScreen(),
      binding: SplashB(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.intro,
      page: () => const IntroScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.logIn,
      page: () => LogInScreen(),
      binding: LogInB(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.signUp,
      page: () => SignUpScreen(),
      binding: SignUpB(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.selectGender,
      page: () => SelectGenderScreen(),
      binding: SelectGenderB(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.selectDuration,
      page: () => SelectDurationScreen(),
      binding: SelectDurationB(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.getOld,
      page: () => const GetOldScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.getWeight,
      page: () => const GetWeightScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.getHeight,
      page: () => const GetHeightScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.fillProfile,
      page: () => const FillProfileScreen(),
      binding: FillProfileB(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.homeScreen,
      page: () => const HomeScreen(),
      binding: HomeScreenBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.dashboardScreen,
      page: () => DashBoardScreen(),
      binding: DashBoardBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.activityTrackerScreen,
      page: () => const ActivityTrackerScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.notificationScreen,
      page: () => NotifiCationScreen(),
      // binding: NotificationBiding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.workoutScheduleScreen,
      page: () => const WorkoutScheduleScreen(),
      transition: Transition.fade,
    )
  ];
}

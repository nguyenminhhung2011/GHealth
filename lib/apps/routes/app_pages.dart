import 'package:get/get_navigation/get_navigation.dart';
import 'package:gold_health/apps/binding/category_meal_binding.dart';
import 'package:gold_health/apps/binding/daily_nutrition_binding.dart';
import 'package:gold_health/apps/binding/fill_profile_binding.dart';
import 'package:gold_health/apps/binding/get_old_binding.dart';
import 'package:gold_health/apps/binding/login_binding.dart';
import 'package:gold_health/apps/binding/meal_detail_binding.dart';
import 'package:gold_health/apps/binding/profile_bindinig.dart';
import 'package:gold_health/apps/binding/select_duration_binding.dart';
import 'package:gold_health/apps/binding/select_gender_binding.dart';
import 'package:gold_health/apps/binding/splash_binding.dart';
import 'package:gold_health/apps/binding/home_screen_binding.dart';
import 'package:gold_health/apps/binding/dashboard_binding.dart';
import 'package:gold_health/apps/controls/dailyPlanController/meal_plan/category_meal_controller.dart';

import 'package:gold_health/apps/pages/IntroListScreen/intro_screen.dart';
import 'package:gold_health/apps/pages/IntroListScreen/splash_screen.dart';
import 'package:gold_health/apps/pages/LogInScreen/login_screen.dart';
import 'package:gold_health/apps/pages/LogInScreen/sign_up_screen.dart';
import 'package:gold_health/apps/pages/basic_info_screen/basic_info_screen.dart';
import 'package:gold_health/apps/pages/basic_info_screen/get_weight_screen.dart';
import 'package:gold_health/apps/pages/basic_info_screen/select_duration_screen.dart';
import 'package:gold_health/apps/pages/dashboard/dashboard_screen.dart';
import 'package:gold_health/apps/pages/dashboard/home_screen.dart';
import 'package:gold_health/apps/pages/dashboard/profile_screen.dart';
import 'package:gold_health/apps/pages/mealPlanner/category_meal_screen.dart';
import 'package:gold_health/apps/pages/mealPlanner/meal_detail_screen.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/workout_detail2_screen.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/workout_schedule_screen.dart';
import 'package:gold_health/apps/routes/route_name.dart';
import 'package:gold_health/apps/pages/dashboard/activity_tracker_screen.dart';
import '../binding/basic_info_binding.dart';
import '../binding/get_height_binding.dart';
import '../binding/get_weight_binding.dart';
import '../pages/dashboard/notification_screen.dart';

import '../binding/dashboard_binding.dart';
import '../binding/sign_up_binding.dart';
import '../pages/basic_info_screen/fill_profile.dart';
import '../pages/basic_info_screen/get_height_screen.dart';
import '../pages/basic_info_screen/get_old_screen.dart';
import '../pages/basic_info_screen/select_gender_screen.dart';
import '../pages/dashboard/home_screen.dart';
import '../pages/list_plan_screen/daili_nutri_screen.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: RouteName.splash,
      page: () => SplashScreen(),
      binding: SplashB(),
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
      name: RouteName.profileScreen,
      page: () => ProfileScreen(),
      binding: ProfileB(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.signUp,
      page: () => SignUpScreen(),
      binding: SignUpB(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.basicInfoScreen,
      page: () => BasicInfoScreen(),
      binding: BasicInfoB(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.selectGender,
      page: () => SelectGenderScreen(),
      binding: SelectGenderB(),
    ),
    GetPage(
      name: RouteName.selectDuration,
      page: () => SelectDurationScreen(),
      //binding: SelectDurationB(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.getOld,
      page: () => const GetOldScreen(),
      //binding: GetOldB(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.getWeight,
      page: () => GetWeightScreen(),
      // binding: GetWeightB(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.getHeight,
      page: () => GetHeightScreen(),
//binding: GetHeightB(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.fillProfile,
      page: () => const FillProfileScreen(),
      // binding: FillProfileB(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.homeScreen,
      page: () => HomeScreen(),
      binding: HomeScreenBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.dashboardScreen,
      page: () => const DashBoardScreen(),
      binding: DashBoardBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.activityTrackerScreen,
      page: () => ActivityTrackerScreen(),
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
    ),
    GetPage(
      name: RouteName.workoutDetail2Screen,
      page: () => const WorkoutDetail2Screen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.dailyNutritionScreen,
      page: () => DailyNutriScreen(),
      binding: DailyNutritionB(),
    ),
    GetPage(
      name: RouteName.mealDetail,
      page: () => MealDetailScreen(),
      binding: MealDetailB(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteName.categoryMeal,
      page: () => CategoryMealScreen(),
      binding: CategoryMealB(),
      transition: Transition.fade,
    ),
  ];
}

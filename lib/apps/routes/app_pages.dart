import 'package:get/get_navigation/get_navigation.dart';
import 'package:gold_health/apps/binding/category_meal_binding.dart';
import 'package:gold_health/apps/binding/daily_nutrition_binding.dart';
import 'package:gold_health/apps/binding/login_binding.dart';
import 'package:gold_health/apps/binding/meal_detail_binding.dart';
import 'package:gold_health/apps/binding/profile_bindinig.dart';
import 'package:gold_health/apps/binding/select_gender_binding.dart';
import 'package:gold_health/apps/binding/splash_binding.dart';
import 'package:gold_health/apps/binding/home_screen_binding.dart';
import 'package:gold_health/apps/binding/dashboard_binding.dart';

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
import 'package:gold_health/apps/pages/sleep_tracker/add_alarm_screen.dart';
import 'package:gold_health/apps/pages/sleep_tracker/sleep_schedule_screen.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/workout_detail2_screen.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/workout_schedule_screen.dart';
import 'package:gold_health/apps/routes/route_name.dart';
import 'package:gold_health/apps/pages/dashboard/activity_tracker_screen.dart';
import '../binding/basic_info_binding.dart';
import '../binding/meal_schedule_binding.dart';
import '../binding/view_meal_binding.dart';
import '../pages/dashboard/notification_screen.dart';

import '../binding/dashboard_binding.dart';
import '../binding/sign_up_binding.dart';
import '../pages/basic_info_screen/fill_profile.dart';
import '../pages/basic_info_screen/get_height_screen.dart';
import '../pages/basic_info_screen/get_old_screen.dart';
import '../pages/basic_info_screen/select_gender_screen.dart';
import '../pages/dashboard/home_screen.dart';
import '../pages/list_plan_screen/add_food_nutri_screen.dart';
import '../pages/list_plan_screen/daili_nutri_screen.dart';
import '../pages/mealPlanner/meal_schedule_screen.dart';
import '../pages/mealPlanner/view_meal_screen.dart';
import '../pages/sleep_tracker/select_time_sleep..dart';
import '../pages/sleep_tracker/sleep_counting_screen.dart';

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
    ),
    GetPage(
      name: RouteName.logIn,
      page: () => const LogInScreen(),
      binding: LogInB(),
    ),
    GetPage(
      name: RouteName.profileScreen,
      page: () => ProfileScreen(),
      binding: ProfileB(),
    ),
    GetPage(
      name: RouteName.signUp,
      page: () => SignUpScreen(),
      binding: SignUpB(),
    ),
    GetPage(
      name: RouteName.basicInfoScreen,
      page: () => BasicInfoScreen(),
      binding: BasicInfoB(),
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
    ),
    GetPage(
      name: RouteName.getOld,
      page: () => const GetOldScreen(),
      //binding: GetOldB(),
    ),
    GetPage(
      name: RouteName.getWeight,
      page: () => GetWeightScreen(),
      // binding: GetWeightB(),
    ),
    GetPage(
      name: RouteName.getHeight,
      page: () => GetHeightScreen(),
//binding: GetHeightB(),
    ),
    GetPage(
      name: RouteName.fillProfile,
      page: () => const FillProfileScreen(),
      // binding: FillProfileB(),
    ),
    GetPage(
      name: RouteName.homeScreen,
      page: () => HomeScreen(),
      binding: HomeScreenBinding(),
    ),
    GetPage(
      name: RouteName.dashboardScreen,
      page: () => const DashBoardScreen(),
      binding: DashBoardBinding(),
    ),
    GetPage(
      name: RouteName.activityTrackerScreen,
      page: () => ActivityTrackerScreen(),
    ),
    GetPage(
      name: RouteName.notificationScreen,
      page: () => NotifiCationScreen(),
      // binding: NotificationBiding(),
    ),
    GetPage(
      name: RouteName.workoutScheduleScreen,
      page: () => const WorkoutScheduleScreen(),
    ),
    // GetPage(
    //   name: RouteName.workoutDetail2Screen,
    //   page: () => const WorkoutDetail2Screen(),
    // ),
    GetPage(
      name: RouteName.dailyNutritionScreen,
      page: () => DailyNutriScreen(),
      binding: DailyNutritionB(),
    ),
    GetPage(
      name: RouteName.mealDetail,
      page: () => MealDetailScreen(),
      binding: MealDetailB(),
    ),
    GetPage(
      name: RouteName.categoryMeal,
      page: () => CategoryMealScreen(),
      binding: CategoryMealB(),
    ),
    GetPage(
      name: RouteName.viewMeal,
      page: () => ViewMealScreen(),
      binding: ViewMealB(),
    ),
    GetPage(
      name: RouteName.addFoodNutri,
      page: () => AddFoodScreen(),
      //    binding: AddFoddNutriB(),
    ),
    GetPage(
      name: RouteName.mealSchedule,
      page: () => MealScheduleScreen(),
      binding: MealScheduleB(),
    ),
    GetPage(
      name: RouteName.sleepSchedule,
      page: () => SleepScheduleScreen(),
    ),
    GetPage(
      name: RouteName.addAlarm,
      page: () => AddAlarmScreen(),
    ),
    GetPage(
      name: RouteName.sleepCounting,
      page: () => SleepCounting(),
    ),
    GetPage(
      name: RouteName.selectSleepTime,
      page: () => const SelectSleepTime(),
    ),
  ];
}

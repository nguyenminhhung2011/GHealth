import 'package:gold_health/apps/data/provider/nutrition_provider.dart';

import '../apps/data/models/Meal.dart';
import '../apps/data/models/nutrition.dart';
import '../apps/data/provider/meal_provider.dart';

class DataService {
  DataService._privateConstructor();
  static final DataService instance = DataService._privateConstructor();

  static late List<Meal> _mealList = [];
  static late List<Meal> _mealBreakFastList = [];
  static late List<Meal> _mealLunchDinnerList = [];
  static late List<Meal> _mealSnackList = [];
  static late List<Nutrition> _nutritonList = [];
  static late List<DateTime> _timeEatList = [];

  static late List<Map<String, dynamic>> _dataNutriPlan = [];

  final _mealProvider = MealProvider();
  final _nutritionProvider = NutritionProvider();

  List<Meal> get mealList => [..._mealList];
  List<Meal> get mealBreakFastList => [..._mealBreakFastList];
  List<Meal> get mealSnackList => [..._mealSnackList];
  List<Meal> get mealLunchDinnerList => [..._mealLunchDinnerList];
  List<Nutrition> get nutritionList => [..._nutritonList];
  List<DateTime> get timeEatList => [..._timeEatList];
  List<Map<String, dynamic>> get dataNutriPlan => [..._dataNutriPlan];

  loadMealList() async {
    if (_mealList.isNotEmpty) return;
    _mealList = await _mealProvider.getAllMeal();
  }

  loadMealBreakFastList() async {
    if (_mealBreakFastList.isNotEmpty) return;
    _mealBreakFastList = await _mealProvider.getAllMealBreakFast();
  }

  loadMealLunchDinnerList() async {
    if (_mealLunchDinnerList.isNotEmpty) return;
    _mealLunchDinnerList = await _mealProvider.getAllMealLunchDinner();
  }

  loadMealSnackList() async {
    if (_mealSnackList.isNotEmpty) return;
    _mealSnackList = await _mealProvider.getAllMealSnackk();
  }

  loadNutritionList() async {
    if (_nutritonList.isNotEmpty) return;
    _nutritonList = await _nutritionProvider.getAllNutrition();
  }

  loadTimeEatList() async {
    if (_timeEatList.isNotEmpty) return;
    _timeEatList = await _mealProvider.getTimeEat();
  }

  loadDataNutriPlan() async {
    if (_dataNutriPlan.isNotEmpty) return;
    _dataNutriPlan = await _nutritionProvider.getDataNutriPlan();
  }
}

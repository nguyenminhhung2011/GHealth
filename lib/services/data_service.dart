import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/data/provider/nutrition_provider.dart';
import 'package:gold_health/constrains.dart';
import 'package:gold_health/services/auth_service.dart';

import '../apps/data/models/Meal.dart';
import '../apps/data/models/nutrition.dart';
import '../apps/data/models/sleep.dart';
import '../apps/data/models/water.dart';
import '../apps/data/provider/meal_provider.dart';
import '../apps/data/provider/water_provider.dart';

class DataService {
  DataService._privateConstructor();
  static final DataService instance = DataService._privateConstructor();

  static late Rx<List<Meal>> _mealList = Rx<List<Meal>>([]);
  static late Rx<List<Meal>> _mealBreakFastList = Rx<List<Meal>>([]);
  static late Rx<List<Meal>> _mealLunchDinnerList = Rx<List<Meal>>([]);
  static late Rx<List<Meal>> _mealSnackList = Rx<List<Meal>>([]);
  static late Rx<List<Nutrition>> _nutritonList = Rx<List<Nutrition>>([]);
  static late Rx<List<DateTime>> _timeEatList = Rx<List<DateTime>>([]);
  static late Rx<List<Water>> _waterConsume = Rx<List<Water>>([]);
  static late Rx<Map<String, dynamic>> _sleepBasicTime =
      Rx<Map<String, dynamic>>({});
  static late Rx<List<Sleep>> _listSleepTIme = Rx<List<Sleep>>([]);

  static late Rx<List<Map<String, dynamic>>> _dataNutriPlan =
      Rx<List<Map<String, dynamic>>>([]);

  final _mealProvider = MealProvider();
  final _nutritionProvider = NutritionProvider();
  final _waterProvider = WaterProvider();
  List<Meal> get mealList => _mealList.value;
  List<Meal> get mealBreakFastList => _mealBreakFastList.value;
  List<Meal> get mealSnackList => _mealSnackList.value;
  List<Meal> get mealLunchDinnerList => _mealLunchDinnerList.value;
  List<Nutrition> get nutritionList => _nutritonList.value;
  List<DateTime> get timeEatList => _timeEatList.value;
  List<Map<String, dynamic>> get dataNutriPlan => _dataNutriPlan.value;
  List<Water> get waterConsume => _waterConsume.value;
  Map<String, dynamic> get sleepBasicTIme => _sleepBasicTime.value;
  List<Sleep> get listSleepTime => _listSleepTIme.value;
  loadMealList() async {
    if (_mealList.value.isNotEmpty) return;
    _mealList.value = await _mealProvider.getAllMeal();
  }

  addNutrition(
    String id,
    int slideValue,
    DateTime date,
  ) async {
    await _nutritionProvider.addNutrition(id, slideValue, date);
    if (_nutritonList.value.isEmpty) return;
    _nutritonList.value
        .add(Nutrition(id: id, amount: slideValue, dateTime: date));
  }

  loadMealBreakFastList() async {
    if (_mealBreakFastList.value.isNotEmpty) return;
    _mealBreakFastList.value = await _mealProvider.getAllMealBreakFast();
  }

  loadMealLunchDinnerList() async {
    if (_mealLunchDinnerList.value.isNotEmpty) return;
    _mealLunchDinnerList.value = await _mealProvider.getAllMealLunchDinner();
  }

  loadMealSnackList() async {
    if (_mealSnackList.value.isNotEmpty) return;
    _mealSnackList.value = await _mealProvider.getAllMealSnackk();
  }

  loadNutritionList() async {
    if (_nutritonList.value.isNotEmpty) return;
    _nutritonList.bindStream(firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('Nutrition')
        .snapshots()
        .map((raw) {
      List<Nutrition> result = [];
      for (var item in raw.docs) {
        result.add(Nutrition.fromSnap(item));
      }
      return result;
    }));
  }

  loadWaterConsumeList() async {
    if (_waterConsume.value.isNotEmpty) return;
    _waterConsume.bindStream(firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('water')
        .snapshots()
        .map((event) {
      List<Water> result = [];
      return result;
    }));
  }

  loadTimeEatList() async {
    if (_timeEatList.value.isNotEmpty) return;
    _timeEatList.value = await _mealProvider.getTimeEat();
  }

  addWaterCollection() async {
    DateTime now = DateTime.now();
    bool check = false;
    QuerySnapshot<Map<String, dynamic>> raw = await firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('water')
        .get();
    for (var item in raw.docs) {
      Water data = Water.fromSnap(item);
      if (data.date.day == now.day &&
          data.date.month == now.month &&
          data.date.year == now.year) {
        return;
      }
    }
    await firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('water')
        .add(
      {
        'date': now,
        'target': 4000,
        'waterConsume': [],
      },
    );
  }

  loadSleepBasicTime() async {
    var data = await firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('sleep_basic_time')
        .doc('sleep')
        .get();
    Map<String, dynamic> dataTemp = data.data() as Map<String, dynamic>;

    _sleepBasicTime.value = {
      'alarm':
          DateTime.fromMillisecondsSinceEpoch(dataTemp['alarm'].seconds * 1000),
      'bedTime': DateTime.fromMillisecondsSinceEpoch(
          dataTemp['bedTime'].seconds * 1000),
      'isTurnOn': dataTemp['isTurnOn'],
      'isTurnOn1': dataTemp['isTurnOn1'],
    };
  }

  loadListSleepTime() async {
    _listSleepTIme.bindStream(firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('sleep_basic_time')
        .doc('sleep')
        .collection('sleep_time')
        .snapshots()
        .map((event) {
      List<Sleep> result = [];
      for (var item in event.docs) {
        result.add(Sleep.fromSnap(item));
      }
      return result;
    }));
  }

  loadDataNutriPlan() async {
    if (_dataNutriPlan.value.isNotEmpty) return;
    _dataNutriPlan.value = await _nutritionProvider.getDataNutriPlan();
  }
}

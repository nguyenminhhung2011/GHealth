import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/Meal.dart';

class DailyNutritionController extends GetxController {
  TextEditingController searchText = TextEditingController();

  final Rx<List<Map<String, dynamic>>> _listFoodToday =
      Rx<List<Map<String, dynamic>>>([]);
  List<Map<String, dynamic>> get listFoodToday =>
      _listFoodToday.value; //  {'id': 'meal 1', 'amount' : 2, 'time':, 'date':}

  final Rx<List<Map<String, dynamic>>> _foodTemp =
      Rx<List<Map<String, dynamic>>>([]);
  List<Map<String, dynamic>> get foodTemp =>
      _foodTemp.value; //  {'id': 'meal 1', 'amount' : 2, 'time':, 'date':}

  final Rx<List<Meal>> _allMeal = Rx<List<Meal>>([]);
  List<Meal> get allMeal => _allMeal.value;

  final Rx<List<Map<String, dynamic>>> _foodSelect =
      Rx<List<Map<String, dynamic>>>([]);
  List<Map<String, dynamic>> get foodSelect =>
      _foodSelect.value; //  {'id': 1, 'select':}

  // RxList<Map<String, dynamic>> listNutri = [
  //   {
  //     'data': 0,
  //     'name': 'Carbs',
  //   },
  //   {
  //     'data': 0,
  //     'name': 'Protein',
  //   },
  //   {
  //     'data': 0,
  //     'name': 'Fat',
  //   },
  // ].obs;

  RxList<Map<String, dynamic>> foodSearch = <Map<String, dynamic>>[].obs;

  //Calculater
  int get sumKcal => (_listFoodToday.value.isEmpty)
      ? 0
      : _listFoodToday.value.fold<int>(0, (sum, e) {
          return sum + _allMeal.value[e['id']].kCal * e["amount"] as int;
        });
  int get sumCarbs => (_listFoodToday.value.isEmpty)
      ? 0
      : _listFoodToday.value.fold<int>(0, (sum, e) {
          return sum + _allMeal.value[e['id']].carbs * e["amount"] as int;
        });

  int get sumProtein => (_listFoodToday.value.isEmpty)
      ? 0
      : _listFoodToday.value.fold<int>(0, (sum, e) {
          return sum + _allMeal.value[e['id']].proteins * e["amount"] as int;
        });

  int get sumFats => (_listFoodToday.value.isEmpty)
      ? 0
      : _listFoodToday.value.fold<int>(0, (sum, e) {
          return sum + _allMeal.value[e['id']].fats * e["amount"] as int;
        });

  clearFoodTemp() {
    _foodTemp.value.clear();
    for (var item in _foodSelect.value) {
      item['select'] = false;
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _allMeal.value = Get.arguments as List<Meal>;
    for (int i = 0; i < _allMeal.value.length; i++) {
      _foodSelect.value.add(
        {
          'id': i,
          'select': false,
        },
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyNutritionController extends GetxController {
  TextEditingController searchText = TextEditingController();
  RxList<Map<String, dynamic>> listFoodToday = <Map<String, dynamic>>[].obs;

  RxList<RxMap<String, dynamic>> allFood = [
    {
      'name': 'Banh xeo',
      'image': 'assets/images/break.png',
      'kCal': 800,
      'gam': 400,
      'Carbs': 54,
      'Protein': 20,
      'Fat': 20,
      'select': false,
    }.obs,
    {
      'name': 'Banh Kep',
      'image': 'assets/images/lunch.png',
      'kCal': 900,
      'gam': 450,
      'Carbs': 54,
      'Protein': 20,
      'Fat': 20,
      'select': false,
    }.obs,
    {
      'name': 'Banh beo',
      'image': 'assets/images/dinner.png',
      'kCal': 1000,
      'gam': 500,
      'Carbs': 54,
      'Protein': 20,
      'Fat': 20,
      'select': false,
    }.obs,
  ].obs;

  RxList<Map<String, dynamic>> foodSearch = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> foodTemp = <Map<String, dynamic>>[].obs;

  clearFoodTemp() {
    foodTemp.clear();
    for (var item in allFood) {
      item['select'] = false;
    }
  }
}

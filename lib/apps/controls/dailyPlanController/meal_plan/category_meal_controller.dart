import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/constrains.dart';

import '../../../data/models/Meal.dart';

class CategoryMealC extends GetxController {
  final Rx<List<Meal>> _listMeal = Rx<List<Meal>>([]);
  final Rx<List<Meal>> _listMealSearch = Rx<List<Meal>>([]);
  final Rx<int> _time = 1.obs;
  TextEditingController searchController = TextEditingController();
  List<Meal> get listMeal => _listMeal.value;
  List<Meal> get listMealSearch => _listMealSearch.value;

  @override
  void onInit() {
    super.onInit();
    getListMeal();
    searchController = TextEditingController();
  }

  getListMeal() {
    _listMeal.value = Get.arguments as List<Meal>;
    update();
  }

  searchMeal(String text) async {
    _listMealSearch.value.clear();
    _listMealSearch.bindStream(
      firestore
          .collection('meal')
          .where('name', isGreaterThanOrEqualTo: searchController.text)
          .snapshots()
          .map(
        (event) {
          List<Meal> result = [];
          for (var item in event.docs) {
            Meal temp = Meal.fromSnap(item);
            if (temp.time == listMeal[0].time) {
              result.add(temp);
            }
          }
          return result;
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/constrains.dart';

import '../../../data/models/Meal.dart';
import '../../../routes/route_name.dart';

class CategoryMealC extends GetxController {
  final Rx<List<Meal>> _listMeal = Rx<List<Meal>>([]);
  final Rx<List<Meal>> _listMealSearch = Rx<List<Meal>>([]);

  List<Map<String, dynamic>> listCategory = [
    {
      'name': 'Salad',
      'asset': 'assets/images/eating.png',
    },
    {
      'name': 'Cake',
      'asset': 'assets/images/break.png',
    },
    {
      'name': 'Smooth',
      'asset': 'assets/images/smoothing.png',
    },
    {
      'name': 'Soups',
      'asset': 'assets/images/soup.png',
    },
    {
      'name': 'Fried',
      'asset': 'assets/images/lunch.png',
    },
    {
      'name': 'Rice',
      'asset': 'assets/images/sushi.png',
    }
  ];

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

  onClickCategoryCard(String cate) {
    List<Meal> arguments = [];
    for (var item in _listMeal.value) {
      if (item.category.contains(cate)) {
        arguments.add(item);
      }
    }
    Get.toNamed(RouteName.viewMeal, arguments: arguments);
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

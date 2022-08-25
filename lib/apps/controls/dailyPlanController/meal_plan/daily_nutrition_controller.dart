import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/data/models/nutrition.dart';
import 'package:gold_health/services/auth_service.dart';

import '../../../../constrains.dart';
import '../../../data/models/Meal.dart';

class DailyNutritionController extends GetxController {
  TextEditingController searchText = TextEditingController();
  final Rx<List<Map<String, dynamic>>> _listFoodToday =
      Rx<List<Map<String, dynamic>>>([]);
  final Rx<List<Map<String, dynamic>>> _foodTemp =
      Rx<List<Map<String, dynamic>>>([]);
  final Rx<List<Meal>> _allMeal = Rx<List<Meal>>([]);
  final Rx<List<Map<String, dynamic>>> _foodSelect =
      Rx<List<Map<String, dynamic>>>([]);
  final Rx<List<Meal>> _listMealSearch = Rx<List<Meal>>([]);

  List<Map<String, dynamic>> get listFoodToday =>
      _listFoodToday.value; //  {'id': 'meal 1', 'amount' : 2, 'time':, 'date':}
  List<Map<String, dynamic>> get foodTemp =>
      _foodTemp.value; //  {'id': 'meal 1', 'amount' : 2, 'time':, 'date':}
  List<Meal> get allMeal => _allMeal.value;
  List<Map<String, dynamic>> get foodSelect =>
      _foodSelect.value; //  {'id': 1, 'select':}

  List<Meal> get listMealSearch => _listMealSearch.value;

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
    getAllListFoodToday();
  }

  getAllListFoodToday() async {
    _listFoodToday.bindStream(firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('Nutrition')
        .snapshots()
        .map((event) {
      List<Map<String, dynamic>> result = [];
      DateTime date = DateTime.now();
      for (var item in event.docs) {
        DateTime dateTemp = DateTime.fromMillisecondsSinceEpoch(
            item.data()['dateTime'].seconds * 1000);
        if (dateTemp.year == date.year &&
            dateTemp.month == date.month &&
            dateTemp.day == date.day) {
          result.add({
            'id': item.data()['id'],
            'amount': item.data()['amount'],
            'dateTime': dateTemp,
          });
        }
      }
      return result;
    }));
  }

  selectFalseandRemoveFoodTemp(int index) {
    _foodSelect.value[index]['select'] = false;
    _foodTemp.value.removeWhere(
        (element) => element['id'] == _foodSelect.value[index]['id']);

    update();
  }

  selectTrueAndAddFoodTemp(int index, double slideValue) async {
    DateTime date = DateTime.now();
    String result = await addNutriToFirebase(index, slideValue, date);
    if (result == "Success") {
      _foodSelect.value[index]['select'] = true;
      _foodTemp.value.add(
        {
          'id': index,
          'amount': slideValue.round(),
          'dateTime': date,
        },
      );
    }
    update();
  }

  Future<String> addNutriToFirebase(
      int index, double slideValue, DateTime date) async {
    String result = "Some errors";
    try {
      Nutrition nutri = Nutrition(
        id: index,
        amount: slideValue.round(),
        dateTime: date,
      );
      await firestore
          .collection('users')
          .doc(AuthService.instance.currentUser!.uid)
          .collection('Nutrition')
          .add(nutri.toJson());
      result = "Success";
      return result;
    } catch (err) {
      // ignore: avoid_print
      print(err.toString());
      result = err.toString();
      return result;
    }
  }

  searchMeal(String text) async {
    _listMealSearch.value.clear();
    _listMealSearch.bindStream(
      firestore
          .collection('meal')
          .where('name', isGreaterThanOrEqualTo: searchText.text)
          .snapshots()
          .map(
        (event) {
          List<Meal> result = [];
          for (var item in event.docs) {
            Meal temp = Meal.fromSnap(item);
            result.add(temp);
          }
          return result;
        },
      ),
    );
    update();
  }

  void udate() {
    update();
  }
}

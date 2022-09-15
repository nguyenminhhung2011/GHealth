import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/services/auth_service.dart';

import '../../../../constrains.dart';
import '../../../data/models/Meal.dart';

class DailyNutritionController extends GetxController {
  TextEditingController searchText = TextEditingController();
  Rx<DateTime> dateSelect = DateTime.now().obs;
  final Rx<List<Map<String, dynamic>>> _listFoodToday =
      Rx<List<Map<String, dynamic>>>([]);
  final Rx<List<Map<String, dynamic>>> _foodTemp =
      Rx<List<Map<String, dynamic>>>([]);
  final Rx<List<Meal>> _allMeal = Rx<List<Meal>>([]);
  final Rx<List<Map<String, dynamic>>> _foodSelect =
      Rx<List<Map<String, dynamic>>>([]);
  final Rx<List<Meal>> _listMealSearch = Rx<List<Meal>>([]);
  Rx<Map<String, dynamic>> mealFindCate = Rx<Map<String, dynamic>>({});

  List<Map<String, dynamic>> get listFoodToday =>
      _listFoodToday.value; //  {'id': 'meal 1', 'amount' : 2, 'time':, 'date':}
  List<Map<String, dynamic>> get foodTemp =>
      _foodTemp.value; //  {'id': 'meal 1', 'amount' : 2, 'time':, 'date':}
  List<Meal> get allMeal => _allMeal.value;
  List<Map<String, dynamic>> get foodSelect =>
      _foodSelect.value; //  {'id': 'meal 1', 'select':}

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
  Meal getMealFromId(String id, List<Meal> l) {
    final meal = l.firstWhere(
      (element) => element.id == id,
      orElse: () {
        return l[0];
      },
    );
    return meal;
  }

  Map<String, dynamic> getFoodSelectFromId(String id) {
    final meal = _foodSelect.value.firstWhere((element) => element['id'] == id,
        orElse: () {
      return _foodSelect.value[0];
    });
    return meal;
  }

  RxList<Map<String, dynamic>> foodSearch = <Map<String, dynamic>>[].obs;

  //Calculater
  int get sumKcal => (_listFoodToday.value.isEmpty)
      ? 0
      : _listFoodToday.value.fold<int>(0, (sum, e) {
          return sum + getMealFromId(e['id'], allMeal).kCal * e["amount"]
              as int;
        });
  int get sumCarbs => (_listFoodToday.value.isEmpty)
      ? 0
      : _listFoodToday.value.fold<int>(0, (sum, e) {
          return sum + getMealFromId(e['id'], allMeal).carbs * e["amount"]
              as int;
        });

  int get sumProtein => (_listFoodToday.value.isEmpty)
      ? 0
      : _listFoodToday.value.fold<int>(0, (sum, e) {
          return sum + getMealFromId(e['id'], allMeal).proteins * e["amount"]
              as int;
        });

  int get sumFats => (_listFoodToday.value.isEmpty)
      ? 0
      : _listFoodToday.value.fold<int>(0, (sum, e) {
          return sum + getMealFromId(e['id'], allMeal).fats * e["amount"]
              as int;
        });

  clearFoodTemp() {
    _foodTemp.value.clear();
    for (var item in _foodSelect.value) {
      item['select'] = false;
    }
    update();
  }

  List<String> mealPlan = [
    'BreakFast',
    'Lunch',
    'Dinner',
    'Snack',
  ];

  @override
  void onInit() {
    super.onInit();
    _allMeal.value = Get.arguments['allMeal'] as List<Meal>;
    mealFindCate.value = {
      'BreakFast': Get.arguments['break'] as List<Meal>,
      'Lunch': Get.arguments['lunch'] as List<Meal>,
      'Snack': Get.arguments['snack'] as List<Meal>,
      'Dinner': Get.arguments['dinner'] as List<Meal>,
    };

    for (int i = 0; i < _allMeal.value.length; i++) {
      _foodSelect.value.add(
        {
          'id': _allMeal.value[i].id,
          'select': false,
        },
      );
    }
    getAllListFoodToday();
  }

  uploadMealActiToFirebase(String id, int amount) async {
    try {
      await firestore
          .collection('users')
          .doc(AuthService.instance.currentUser!.uid)
          .collection('activity_history')
          .add(
        {
          'type': 1,
          'consume': 0,
          'date': DateTime.now(),
          'kCalConsume': getMealFromId(id, allMeal).kCal * amount,
          'kCalBurn': 0,
        },
      );
    } catch (e) {
      print('Failed to upload');
    }
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

  selectFalseandRemoveFoodTemp(String id) {
    final meal = getFoodSelectFromId(id);
    _foodSelect.value[_foodSelect.value
        .indexWhere((element) => element['id'] == id)]['select'] = false;
    _foodTemp.value.removeWhere((element) => element['id'] == meal['id']);
    update();
  }

  selectTrueAndAddFoodTemp(String id, double slideValue) async {
    DateTime date = DateTime.now();

    _foodSelect.value[_foodSelect.value
        .indexWhere((element) => element['id'] == id)]['select'] = true;
    _foodTemp.value.add(
      {
        'id': id,
        'amount': slideValue.round(),
        'dateTime': date,
      },
    );

    update();
  }

  // Future<void> addNutriToFirebase(
  //     String id, int slideValue, DateTime date) async {
  //   // String result = "Some errors";
  //   try {
  //     Nutrition nutri = Nutrition(
  //       id: id,
  //       amount: slideValue,
  //       dateTime: date,
  //     );
  //     await firestore
  //         .collection('users')
  //         .doc(AuthService.instance.currentUser!.uid)
  //         .collection('Nutrition')
  //         .add(nutri.toJson());
  //     // result = "Success";
  //     return;
  //   } catch (err) {
  //     // ignore: avoid_print
  //     print(err.toString());
  //     // result = err.toString();
  //     return;
  //   }
  // }

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

  selectListFoodByCalender(DateTime timeTemp) {
    dateSelect.value = timeTemp;
    _listFoodToday.bindStream(firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('Nutrition')
        .snapshots()
        .map((event) {
      List<Map<String, dynamic>> result = [];
      for (var item in event.docs) {
        DateTime dateTemp = DateTime.fromMillisecondsSinceEpoch(
            item.data()['dateTime'].seconds * 1000);
        if (dateTemp.year == dateSelect.value.year &&
            dateTemp.month == dateSelect.value.month &&
            dateTemp.day == dateSelect.value.day) {
          result.add({
            'id': item.data()['id'],
            'amount': item.data()['amount'],
            'dateTime': dateTemp,
          });
        }
      }
      return result;
    }));
    update();
  }

  Rx<String> selectPlan = 'BreakFast'.obs;

  void udate() {
    update();
  }
}

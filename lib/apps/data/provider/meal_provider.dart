import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gold_health/apps/data/models/Meal.dart';
import 'package:gold_health/services/auth_service.dart';

// fecth data Meal
class MealProvider {
  final _firestore = FirebaseFirestore.instance;
  @override
  Future<List<Meal>> getAllMeal() async {
    QuerySnapshot<Map<String, dynamic>> raw =
        await _firestore.collection('meal').get();
    List<Meal> result = [];
    for (var item in raw.docs) {
      result.add(Meal.fromSnap(item));
    }
    return result;
  }

  Meal getMealId(String id, List<Meal> l) {
    final meal = l.firstWhere(
      (element) => element.id == id,
      orElse: () {
        return l[0];
      },
    );
    return meal;
  }

  Future<List<Meal>> getAllMealBreakFast() async {
    QuerySnapshot<Map<String, dynamic>> raw =
        await _firestore.collection('meal').get();
    List<Meal> result = [];
    for (var item in raw.docs) {
      if (item.data()['time'] == 1) {
        result.add(Meal.fromSnap(item));
      }
    }
    return result;
  }

  Future<List<Meal>> getAllMealLunchDinner() async {
    QuerySnapshot<Map<String, dynamic>> raw =
        await _firestore.collection('meal').get();
    List<Meal> result = [];
    for (var item in raw.docs) {
      if (item.data()['time'] == 2) {
        result.add(Meal.fromSnap(item));
      }
    }
    return result;
  }

  Future<List<Meal>> getAllMealSnackk() async {
    QuerySnapshot<Map<String, dynamic>> raw =
        await _firestore.collection('meal').get();
    List<Meal> result = [];
    for (var item in raw.docs) {
      if (item.data()['time'] == 3) {
        result.add(Meal.fromSnap(item));
      }
    }
    return result;
  }

  Future<List<DateTime>> getTimeEat() async {
    QuerySnapshot<Map<String, dynamic>> raw = await _firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('timeEat')
        .get();
    List<DateTime> result = [];
    Map<String, dynamic> listTime = raw.docs[0].data();
    for (var item in listTime['list']) {
      result.add(DateTime.fromMillisecondsSinceEpoch(item.seconds * 1000));
    }
    return result;
  }
}

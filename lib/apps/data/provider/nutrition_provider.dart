import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gold_health/services/auth_service.dart';

import '../models/nutrition.dart';

//fetch data Nutrition and planMeal
class NutritionProvider {
  final _firestore = FirebaseFirestore.instance;
  @override
  Future<List<Nutrition>> getAllNutrition() async {
    QuerySnapshot<Map<String, dynamic>> raw = await _firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('Nutrition')
        .get();
    List<Nutrition> result = [];
    for (var item in raw.docs) {
      result.add(Nutrition.fromSnap(item));
    }
    return result;
  }

  Future<void> addNutrition(
    String id,
    int slideValue,
    DateTime date,
  ) async {
    Nutrition nutri = Nutrition(
      id: id,
      amount: slideValue,
      dateTime: date,
    );
    await _firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('Nutrition')
        .add(nutri.toJson());
    return;
  }

  Future<List<Map<String, dynamic>>> getListFoodNutriByCalender(
      DateTime dateSelect) async {
    QuerySnapshot<Map<String, dynamic>> raw = await _firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('Nutrition')
        .get();

    List<Map<String, dynamic>> result = [];
    for (var item in raw.docs) {
      DateTime dateTemp = DateTime.fromMillisecondsSinceEpoch(
          item.data()['dateTime'].seconds * 1000);
      if (dateTemp.year == dateSelect.year &&
          dateTemp.month == dateSelect.month &&
          dateTemp.day == dateSelect.day) {
        result.add({
          'id': item.data()['id'],
          'amount': item.data()['amount'],
          'dateTime': dateTemp,
        });
      }
    }
    return result;
  }

  Future<List<Map<String, dynamic>>> getDataNutriPlan() async {
    QuerySnapshot<Map<String, dynamic>> raw =
        await _firestore.collection('PlanMeal').get();

    List<Map<String, dynamic>> result = [
      for (int i = 1; i <= 7; i++)
        {
          'id': i,
          'kCal': 0,
          'pro': 0,
          'fats': 0,
          'carbs': 0,
        }
    ];
    for (var item in raw.docs) {
      var data = item.data();
      result[data['id'] - 1]['kCal'] = data['listNutri'][0];
      result[data['id'] - 1]['pro'] = data['listNutri'][1];
      result[data['id'] - 1]['fats'] = data['listNutri'][2];
      result[data['id'] - 1]['carbs'] = data['listNutri'][3];
    }
    return result;
  }
}

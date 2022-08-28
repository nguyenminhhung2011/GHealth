import 'package:cloud_firestore/cloud_firestore.dart';

class MealPlan {
  String id;
  List listMealBreak;
  List listMealLunch;
  List listSnack;
  List listMealDinner;

  MealPlan({
    required this.id,
    required this.listMealBreak,
    required this.listMealLunch,
    required this.listMealDinner,
    required this.listSnack,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'listMealBreak': listMealBreak,
        'listMealLunch': listMealLunch,
        'listSnack': listSnack,
        'listMealDinner': listMealDinner,
      };
  factory MealPlan.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return MealPlan(
      id: snapshot['id'] ?? 1,
      listMealBreak: snapshot['listMealBreak'] ?? [],
      listMealLunch: snapshot['listMealLunch'] ?? [],
      listSnack: snapshot['listSnack'] ?? [],
      listMealDinner: snapshot['listMealDinner'] ?? [],
    );
  }
}

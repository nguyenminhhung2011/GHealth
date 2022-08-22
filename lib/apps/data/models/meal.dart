import 'package:cloud_firestore/cloud_firestore.dart';

class Meal {
  final String id;
  final String name;
  final String asset;
  final int time; // 1: breakfast 2: lunch 3: dinner
  final String description;
  final int kCal;
  final int fats;
  final int proteins;
  final int carbs;
  final List steps;
  final List listIngredient;
  Meal({
    required this.id,
    required this.name,
    required this.asset,
    required this.time,
    required this.description,
    required this.steps,
    required this.kCal,
    required this.fats,
    required this.proteins,
    required this.carbs,
    required this.listIngredient,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'asset': asset,
        'time': time,
        'description': description,
        'listIngredient': listIngredient,
        'steps': steps,
        'kCal': kCal,
        'fats': fats,
        'proteins': proteins,
        'carbs': carbs,
      };

  static Meal fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Meal(
      id: snapshot['id'],
      name: snapshot['name'] ?? '',
      asset: snapshot['asset'] ?? '',
      time: snapshot['time'] ?? 1,
      description: snapshot['description'] ?? 'No description',
      listIngredient: snapshot['listIngredient'] ?? [],
      steps: snapshot['steps'] ?? [],
      kCal: snapshot['kCal'] ?? 0,
      fats: snapshot['fats'] ?? 0,
      proteins: snapshot['proteins'] ?? 0,
      carbs: snapshot['carbs'] ?? 0,
    );
  }

  static Meal fromMap(Map<String, dynamic> snapshot) {
    return Meal(
      id: snapshot['id'],
      name: snapshot['name'] ?? '',
      asset: snapshot['asset'] ?? '',
      time: snapshot['time'] ?? 1,
      description: snapshot['description'] ?? 'No description',
      listIngredient: snapshot['listIngredient'] ?? [],
      steps: snapshot['steps'] ?? [],
      kCal: snapshot['kCal'] ?? 0,
      fats: snapshot['fats'] ?? 0,
      proteins: snapshot['proteins'] ?? 0,
      carbs: snapshot['carbs'] ?? 0,
    );
  }
}

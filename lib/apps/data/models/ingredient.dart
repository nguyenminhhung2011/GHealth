import 'package:cloud_firestore/cloud_firestore.dart';

class Ingredient {
  final String id;
  final String name;
  final String assets;
  final int kCal;
  final int fats;
  final int proteins;
  final int carbs;

  Ingredient({
    required this.id,
    required this.name,
    required this.kCal,
    required this.fats,
    required this.proteins,
    required this.carbs,
    required this.assets,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'kCal': kCal,
        'fats': fats,
        'proteins': proteins,
        'carbs': carbs,
        'assets': assets,
      };
  static Ingredient fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Ingredient(
      id: snapshot['id'],
      name: snapshot['name'],
      kCal: snapshot['kCal'],
      fats: snapshot['fats'],
      proteins: snapshot['proteins'],
      carbs: snapshot['carbs'],
      assets: snapshot['assets'],
    );
  }
}

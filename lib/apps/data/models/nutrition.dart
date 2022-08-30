import 'package:cloud_firestore/cloud_firestore.dart';

class Nutrition {
  String id;
  int amount;
  DateTime dateTime;
  Nutrition({
    required this.id,
    required this.amount,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'dateTime': dateTime,
      };

  factory Nutrition.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Nutrition(
      id: snapshot['id'] ?? '',
      amount: snapshot['amount'] ?? 0,
      dateTime: DateTime.fromMillisecondsSinceEpoch(
          snapshot['dateTime'].seconds * 1000),
    );
  }
}

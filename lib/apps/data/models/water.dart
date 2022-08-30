import 'package:cloud_firestore/cloud_firestore.dart';

class Water {
  DateTime date;
  int target;
  List<Map<String, dynamic>> waterConsume;
  Water({
    required this.date,
    required this.target,
    required this.waterConsume,
  });

  Map<String, dynamic> toJson() => {
        'date': date,
        'target': target,
        'waterConsume': waterConsume,
      };
  factory Water.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    List<Map<String, dynamic>> waterConsume = [];
    if (snapshot['waterConsume'].length > 0) {
      for (var item in snapshot['waterConsume']) {
        waterConsume.add({
          'consume': item['consume'],
          'date':
              DateTime.fromMillisecondsSinceEpoch(item['date'].seconds * 1000),
        });
      }
    }
    return Water(
      date: DateTime.fromMillisecondsSinceEpoch(
        snapshot['date'].seconds * 1000,
      ),
      target: snapshot['target'],
      waterConsume: waterConsume,
    );
  }
}

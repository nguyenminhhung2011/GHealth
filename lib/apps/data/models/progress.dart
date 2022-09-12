import 'package:cloud_firestore/cloud_firestore.dart';

class Progres {
  String id;
  DateTime date;
  List image;
  Progres({
    required this.id,
    required this.date,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'image': image,
      };

  factory Progres.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Progres(
      id: snap.id,
      date:
          DateTime.fromMillisecondsSinceEpoch(snapshot['date']?.seconds * 1000),
      image: snapshot['image'] ?? [],
    );
  }
}

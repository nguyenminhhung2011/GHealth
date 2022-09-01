import 'package:cloud_firestore/cloud_firestore.dart';

class Sleep {
  String id;
  DateTime bedTime;
  DateTime alarm;
  bool isTurnOn;
  bool isTurnOn1;
  List listDate;
  Sleep({
    required this.id,
    required this.bedTime,
    required this.alarm,
    required this.isTurnOn,
    required this.isTurnOn1,
    required this.listDate,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'bedTime': bedTime,
        'alarm': alarm,
        'isTurnOn': isTurnOn,
        'isTurnOn1': isTurnOn1,
        'listDate': listDate,
      };

  factory Sleep.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Sleep(
      id: snapshot['id'] ?? '',
      bedTime: DateTime.fromMillisecondsSinceEpoch(
          snapshot['bedTime'].seconds * 1000),
      alarm:
          DateTime.fromMillisecondsSinceEpoch(snapshot['alarm'].seconds * 1000),
      isTurnOn: snapshot['isTurnOn'] ?? true,
      isTurnOn1: snapshot['isTurnOn1'] ?? true,
      listDate: snapshot['listDate'] ?? [],
    );
  }
}

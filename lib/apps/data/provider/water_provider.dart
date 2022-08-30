import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../services/auth_service.dart';
import '../models/water.dart';

class WaterProvider {
  final _firestore = FirebaseFirestore.instance;

  Future<bool> checkHave() async {
    DateTime now = DateTime.now();
    QuerySnapshot<Map<String, dynamic>> raw = await _firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('water')
        .get();
    for (var item in raw.docs) {
      Water data = Water.fromSnap(item);
      if (data.date.day == now.day &&
          data.date.month == now.month &&
          data.date.year == now.year) {
        return true;
      }
    }
    return false;
  }
}

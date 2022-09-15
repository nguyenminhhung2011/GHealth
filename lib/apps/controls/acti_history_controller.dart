import 'package:get/get.dart';
import 'package:gold_health/constrains.dart';

import '../../services/auth_service.dart';

class ActiHistoriC extends GetxController {
  final Rx<List<Map<String, dynamic>>> _listActi =
      Rx<List<Map<String, dynamic>>>([]);
  List<Map<String, dynamic>> get listActi => _listActi.value;
  getAllActi() async {
    try {
      _listActi.bindStream(firestore
          .collection('users')
          .doc(AuthService.instance.currentUser!.uid)
          .collection('activity_history')
          .snapshots()
          .map((event) {
        List<Map<String, dynamic>> result = [];
        for (var item in event.docs) {
          result.add(
            {
              'id': item.id,
              'consume': item.data()['consume'],
              'date': DateTime.fromMillisecondsSinceEpoch(
                  item.data()['date'].seconds * 1000),
              'kCalBurn': item.data()['kCalBurn'],
              'kCalConsume': item.data()['kCalConsume'],
              'type': item.data()['type'],
            },
          );
        }
        return result;
      }));
      update();
    } catch (e) {
      print(e);
    }
  }

  deleteActiFromFirebase(String id) async {
    try {
      await firestore
          .collection('users')
          .doc(AuthService.instance.currentUser!.uid)
          .collection('activity_history')
          .doc(id)
          .delete();
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getAllActi();
  }
}

import 'package:get/get.dart';

import '../../../constrains.dart';
import '../../../services/auth_service.dart';
import '../../data/models/progress.dart';

class ProgressC extends GetxController {
  final Rx<List<Progres>> _listProgress = Rx<List<Progres>>([]);
  List<Progres> get listProgress => _listProgress.value;
  Future<void> fetchAllProgress() async {
    try {
      _listProgress.bindStream(
        firestore
            .collection('users')
            .doc(AuthService.instance.currentUser!.uid)
            .collection('progress')
            .snapshots()
            .map(
          (event) {
            List<Progres> result = [];
            for (var item in event.docs) {
              result.add(Progres.fromSnap(item));
            }
            return result;
          },
        ),
      );
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await fetchAllProgress();
  }
}

import 'package:get/get.dart';
import 'package:gold_health/constrains.dart';
// import 'package:age/age.dart';

import '../../services/auth_service.dart';

class ProfileC extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;
  final Rx<List<Map<String, dynamic>>> listWeightCollection =
      Rx<List<Map<String, dynamic>>>([]);
  final Rx<String> _uid = "".obs;

  // AgeDuration get getAge {
  //   DateTime birthday = DateTime.fromMillisecondsSinceEpoch(
  //       _user.value['dateOfBirth'].seconds * 1000);
  //   DateTime today = DateTime.now();
  //   AgeDuration age;

  //   // Find out your age
  //   age = Age.dateDifference(
  //       fromDate: birthday, toDate: today, includeToDate: false);
  //   return age;
  // }

  @override
  void onInit() {
    super.onInit();
    getAllWeightCollection();
    updateUser(AuthService.instance.currentUser!.uid);
    //ignore: avoid_print
    print(_user.value['uid']);
  }

  @override
  // ignore: unnecessary_overrides
  void onClose() {
    super.onClose();
  }

  // Get user from firestore
  updateUser(String id) {
    _uid.value = id;
    getDataUser(_uid.value);
  }

  getAllWeightCollection() async {
    listWeightCollection.bindStream(firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('weight')
        .snapshots()
        .map((event) {
      List<Map<String, dynamic>> result = [];
      DateTime now = DateTime.now();
      for (var item in event.docs) {
        DateTime date = DateTime.fromMicrosecondsSinceEpoch(
            item.data()['date'].seconds * 1000);
        if (date.year == now.year &&
            date.month == now.month &&
            date.day == now.day) {
          result.add({
            'id': item.id,
            'data': item.data()['data'],
            'date': date,
          });
          break;
        }
      }
      return result;
    }));
  }

  addWeightToCollection(int newValue) async {
    if (listWeightCollection.value.isNotEmpty) {
      await firestore
          .collection('users')
          .doc(AuthService.instance.currentUser!.uid)
          .collection('weight')
          .doc(listWeightCollection.value[0]['id'])
          .update({'data': newValue});
    } else {
      await firestore
          .collection('users')
          .doc(AuthService.instance.currentUser!.uid)
          .collection('weight')
          .add({
        'data': newValue,
        'date': DateTime.now(),
      });
    }
  }

  updateWeight(int newValue) async {
    await firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .update(
      {'weight': newValue},
    );
    await addWeightToCollection(newValue);
  }

  getDataUser(String uid) async {
    _user.bindStream(firestore.collection('users').snapshots().map((event) {
      Map<String, dynamic> result = {};
      for (var item in event.docs) {
        if (item.id == AuthService.instance.currentUser!.uid) {
          result = item.data();
          break;
        }
      }
      return result;
    }));
    update();
  }
}

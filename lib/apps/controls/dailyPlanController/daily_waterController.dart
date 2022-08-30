import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/tracker_controller.dart';
import '../../../constrains.dart';
import '../../../services/auth_service.dart';
import '../../../services/data_service.dart';
import '../../data/models/water.dart';

class DailyWaterController extends GetxController with TrackerController {
  RxList<Map<String, dynamic>> waterConsumeToday = <Map<String, dynamic>>[].obs;
  final Rx<Map<String, dynamic>> _waterToday = Rx<Map<String, dynamic>>({});
  final Rx<List<Map<String, dynamic>>> _waterConsume =
      Rx<List<Map<String, dynamic>>>([]);

  Map<String, dynamic> get waterToday => _waterToday.value;
  List<Map<String, dynamic>> get waterConsumer => _waterConsume.value;

  Rx<int> waterTarget = 4000.obs;
  String id = '';
  // Rx<int> waterConsume = 200.obs;

  List<Water> get allWaterConsume => DataService.instance.waterConsume;

  int get waterCon => (_waterToday.value.isNotEmpty)
      ? (_waterToday.value['waterConsume'] as List).fold<int>(0, (sum, e) {
          return sum + e['consume'] as int;
        })
      : 0;

  // int waterConsumer() {
  //   int result = 0;
  //   for (var item in _waterToday.value['waterConsume']) {

  //   }
  // }

  @override
  void onInit() {
    super.onInit();
    getWaterToday();
  }

  getWaterToday() async {
    DateTime now = DateTime.now();
    _waterToday.bindStream(
      firestore
          .collection('users')
          .doc(AuthService.instance.currentUser!.uid)
          .collection('water')
          .snapshots()
          .map(
        (event) {
          Map<String, dynamic> result = {};
          for (var item in event.docs) {
            Water data = Water.fromSnap(item);
            if (data.date.day == now.day &&
                data.date.month == now.month &&
                data.date.year == now.year) {
              result = data.toJson();
              id = item.id;
              break;
            }
          }
          return result;
        },
      ),
    );
    update();
  }

  List<Map<String, dynamic>> get waterCons => (_waterToday.value.isNotEmpty)
      ? [
          for (var item in _waterToday.value['waterConsume'])
            {'consume': item['consume'], 'date': item['date']}
        ]
      : [];

  updateWaterTargetAndConsume(int value1, int value2) async {
    List<Map<String, dynamic>> temp = _waterToday.value['waterConsume'];
    if (value2 != 0) {
      temp.add({'consume': value2, 'date': DateTime.now()});
    }

    await firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('water')
        .doc(id)
        .update(
      {
        'date': _waterToday.value['date'],
        'target': value1,
        'waterConsume': temp,
      },
    );
    update();
  }
}

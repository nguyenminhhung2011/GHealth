import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/tracker_controller.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
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

  @override
  void onInit() {
    super.onInit();
    getWaterToday();
    getStartDateAndFinishDate();
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

  DateTime selectDateTemp1 = DateTime.now();
  DateTime selectDateTemp2 = DateTime.now();

  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> finishDate = DateTime.now().obs;
  DateRangePickerController dateController = DateRangePickerController();

  RxList<DateTime> allDateBetWeen = <DateTime>[].obs;

  bool isSameDate(DateTime date1, DateTime date2) {
    if (date2 == date1) {
      return true;
    }
    if (date1 == null || date2 == null) {
      return false;
    }
    return date1.month == date2.month &&
        date1.year == date2.year &&
        date1.day == date2.day;
  }

  // change date select
  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    int firstDayOfWeek = DateTime.sunday % 7;
    int endDayOfWeek = (firstDayOfWeek - 1) % 7;
    endDayOfWeek = endDayOfWeek < 0 ? 7 + endDayOfWeek : endDayOfWeek;
    PickerDateRange ranges = args.value;
    DateTime date1 = ranges.startDate!;
    DateTime date2 = (ranges.endDate ?? ranges.startDate)!;
    if (date1.isAfter(date2)) {
      var date = date1;
      date1 = date2;
      date2 = date;
    }
    int day1 = date1.weekday % 7;
    int day2 = date2.weekday % 7;

    DateTime dat1 = date1.add(Duration(days: (firstDayOfWeek - day1)));
    DateTime dat2 = date2.add(Duration(days: (endDayOfWeek - day2)));

    if (!isSameDate(dat1, ranges.startDate!) ||
        !isSameDate(dat2, ranges.endDate!)) {
      dateController.selectedRange = PickerDateRange(dat1, dat2);
      selectDateTemp1 = dat1;
      selectDateTemp2 = dat2;
    }
  }

  //load data chart with select calendar
  selectDateDoneClick() {
    startDate.value = selectDateTemp1;
    finishDate.value = selectDateTemp2;
    allDateBetWeen.value = getListDateBetWeenRange();
    update();
  }

  // get number date between
  getDayInBetWeen() {
    final int difference = finishDate.value.difference(startDate.value).inDays;
    return difference;
  }

  //get list date to load chart
  List<DateTime> getListDateBetWeenRange() {
    final items = List<DateTime>.generate(getDayInBetWeen() + 1, (index) {
      DateTime date = startDate.value;
      return date.add(Duration(days: index));
    });
    return items;
  }

  //get date start and date finish to load chart
  void getStartDateAndFinishDate() {
    DateTime now = DateTime.now();
    int weekDay = now.weekday == 7 ? 0 : now.weekday;
    startDate.value = DateTime.now();
    finishDate.value = DateTime.now();
    for (int i = 0; i < weekDay; i++) {
      startDate.value = startDate.value.add(const Duration(days: -1));
    }
    for (int i = 0; i < 6 - weekDay; i++) {
      finishDate.value = finishDate.value.add(const Duration(days: 1));
    }
    allDateBetWeen.value = List<DateTime>.generate(
        7, (index) => startDate.value.add(Duration(days: index)));
    update();
  }
}

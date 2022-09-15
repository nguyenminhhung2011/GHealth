import 'package:get/get.dart';
import 'package:gold_health/services/data_service.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../constrains.dart';
import '../data/models/Meal.dart';
import '../data/models/sleep.dart';

class TodayScheduleC extends GetxController {
  final Rx<int> _onFocus = 0.obs;
  int get onFocus => _onFocus.value;
  final Rx<CalendarController> _calendarController = CalendarController().obs;
  CalendarController get calendarController => _calendarController.value;
  Rx<Map<String, dynamic>> mealDate = Rx<Map<String, dynamic>>({});
  List<Sleep> listSleepWithDate(int date) => [
        for (var item in DataService.instance.listSleepTime)
          if (item.listDate.contains(date)) item
      ];
  final List<DateTime> listDateTime = [
    for (int i = 1; i <= 30; i++) DateTime.now().subtract(Duration(days: i)),
    for (int i = 0; i <= 30; i++) DateTime.now().add(Duration(days: i))
  ];
  List<Map<String, dynamic>> listMealPlan = DataService.instance.listMealPlan;

  setFocus(int index, DateTime time) {
    _onFocus.value = index;
    _calendarController.value.displayDate = time;
    // getMealDate(time);
    // getNutriData(listDateTime[index]);
    getMealDate(time);
    update();
  }

  Meal getMealId(String id, List<Meal> l) {
    // get meal from id String
    final meal = l.firstWhere(
      (element) => element.id == id,
      orElse: () {
        return l[0];
      },
    );
    return meal;
  }

  getAllMealPlan() async {
    final listPlan = await firestore.collection('PlanMeal').get();
    final list = listPlan.docs;
    listMealPlan = List<Map<String, dynamic>>.generate(
        list.length, (index) => list[index].data());
  }

  @override
  void onInit() {
    super.onInit();
    DataService.instance.loadMealList();
    DataService.instance.loadDataNutriPlan();
    DataService.instance.loadTimeEatList();
    DataService.instance.loadListSleepTime();
    getMealDate(DateTime.now());
  }

  getMealDate(DateTime date) async {
    int weekDay = date.weekday;
    final listMealId = listMealPlan.firstWhere(
      (element) => element['id'] == weekDay,
    );
    List<Meal> lbreak = [];
    List<Meal> llunch = [];
    List<Meal> lsnack = [];
    List<Meal> ldinner = [];
    for (var item in listMealId['listMealBreak']) {
      Meal temp = getMealId(item, DataService.instance.mealList);

      lbreak.add(temp);
    }
    for (var item in listMealId['listMealLunch']) {
      Meal temp = getMealId(item, DataService.instance.mealList);

      llunch.add(temp);
    }
    for (var item in listMealId['listSnack']) {
      Meal temp = getMealId(item, DataService.instance.mealList);

      lsnack.add(temp);
    }
    for (var item in listMealId['listMealDinner']) {
      Meal temp = getMealId(item, DataService.instance.mealList);

      ldinner.add(temp);
    }
    mealDate.value = {
      'BreakFast': lbreak,
      'Lunch': llunch,
      'Snack': lsnack,
      'Dinner': ldinner,
    };
    update();
  }
}

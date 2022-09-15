import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/data/models/workout_model.dart';
import 'package:gold_health/constrains.dart';

import '../../services/auth_service.dart';
import '../../services/data_service.dart';
import '../data/models/Meal.dart';

class HomeScreenControl extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;
  final Rx<String> _uid = "".obs;

  var notifications = {
    DateTime.now().subtract(const Duration(minutes: 5)): {
      'icon': CircleAvatar(
        child: Image.asset(
          'assets/icons/Ellipse.png',
        ),
      ),
      'title': 'Hey, it\'s time for lunch',
    },
    DateTime.now().subtract(const Duration(hours: 2)): {
      'icon': Image.asset(
        'assets/icons/Ellipse (3).png',
      ),
      'title': 'Don\'t miss your abs workout',
    },
    DateTime.now().subtract(const Duration(hours: 6)): {
      'icon': Image.asset(
        'assets/icons/Ellipse (2).png',
      ),
      'title': 'Hey, let\'t add some meal for your body',
    },
    DateTime.now().subtract(const Duration(days: 10)): {
      'icon': Image.asset(
        'assets/icons/Ellipse (3).png',
      ),
      'title': 'Congratulation, you have finished your workout',
    },
    DateTime.now().subtract(const Duration(days: 50)): {
      'icon': Image.asset(
        'assets/icons/Ellipse (2).png',
      ),
      'title': 'Hey, it\'s time for lunch',
    },
    DateTime.now().subtract(const Duration(days: 100)): {
      'icon': Image.asset(
        'assets/icons/Ellipse.png',
      ),
      'title': 'Ups, You have missed your lowerbody workout',
    },
  }.obs;

  bool get isNotify {
    if (notifications.isEmpty) return false;
    return true;
  }

  void deleteNotification(DateTime key) {
    notifications.remove(key);
    if (notifications.values.isEmpty) {
      notifications.refresh();
    }
  }

  final Rx<List<Map<String, dynamic>>> waterViewData =
      Rx<List<Map<String, dynamic>>>([]);

  String convertIntHour(int hour) {
    return (hour <= 12) ? '${hour}am' : '${hour - 12}pm';
  }

  int get sumWater => waterViewData.value.fold<int>(0, (sum, e) {
        return sum + e['data'] as int;
      });
  RxInt kCalBurn = 0.obs;
  RxInt kCalConsume = 0.obs;

  getkCalBurn() async {
    kCalBurn.bindStream(firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('workout_history')
        .snapshots()
        .map((event) {
      int result = 0;
      DateTime now = DateTime.now();
      for (var item in event.docs) {
        DateTime time = DateTime.fromMillisecondsSinceEpoch(
            item.data()['time'].seconds * 1000);
        if (time.day == now.day &&
            time.month == now.month &&
            time.year == now.year) {
          result += int.parse(item.data()['caloriesBurn']);
        }
      }
      return result;
    }));
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

  getkCalConsume() async {
    kCalConsume.bindStream(firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('Nutrition')
        .snapshots()
        .map((event) {
      int result = 0;
      DateTime now = DateTime.now();
      for (var item in event.docs) {
        DateTime time = DateTime.fromMillisecondsSinceEpoch(
            item.data()['dateTime'].seconds * 1000);
        if (time.day == now.day &&
            time.month == now.month &&
            time.year == now.year) {
          result +=
              getMealId(item.data()['id'], DataService.instance.mealList).kCal *
                  (item.data()['amount'] as int);
        }
      }
      return result;
    }));
  }

  Future<int> getExerciseTimeData() async {
    int time = 0;
    try {
      await Future(() async {
        String userId = AuthService.instance.currentUser!.uid;
        final data = await firestore
            .collection('users')
            .doc(userId)
            .collection('workout_plan')
            .get();
        for (var doc in data.docs) {
          final workoutId = doc.data()['workoutPlanID'] as String;
          final temp =
              await firestore.collection('workout_plan').doc(workoutId).get();
          time += int.parse(temp.get('targetTime') as String);
        }
      });
      return time;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getExerciseTimeHistory() async {
    int time = 0;
    try {
      await Future(() async {
        String userId = AuthService.instance.currentUser!.uid;
        final data = await firestore
            .collection('users')
            .doc(userId)
            .collection('workout_history')
            .get();
        for (var doc in data.docs) {
          WorkoutHistory temp = WorkoutHistory.fromSnap(doc);
          if (temp.time.day == DateTime.now().day &&
              temp.time.month == DateTime.now().month &&
              temp.time.year == DateTime.now().year) {
            print(temp.time);
            time += temp.duration.inMinutes;
          }
        }
      });
      return time;
    } catch (e) {
      rethrow;
    }
  }

  getSteepTimeData() {}

  getSleepTimeData() {}

  loadWaterdata() async {
    waterViewData.bindStream(firestore
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('water')
        .snapshots()
        .map((event) {
      List<Map<String, dynamic>> result = [
        {
          'hour': [6, 10],
          'data': 0,
        },
        {
          'hour': [10, 13],
          'data': 0,
        },
        {
          'hour': [13, 17],
          'data': 0,
        },
        {
          'hour': [17, 21],
          'data': 0,
        },
        {
          'hour': [21, 24],
          'data': 0,
        }
      ];
      DateTime now = DateTime.now();
      Map<String, dynamic> dataTemp = {};
      for (var item in event.docs) {
        DateTime dateTemp = DateTime.fromMillisecondsSinceEpoch(
            item.data()['date'].seconds * 1000);
        if (dateTemp.day == now.day &&
            dateTemp.month == now.month &&
            dateTemp.year == now.year) {
          dataTemp = item.data();
          break;
        }
      }

      if (dataTemp != {}) {
        for (var item in dataTemp['waterConsume']) {
          int time =
              DateTime.fromMillisecondsSinceEpoch(item['date'].seconds * 1000)
                  .hour;
          int index = result
              .indexWhere((e) => (time >= e['hour'][0] && time < e['hour'][1]));
          // returnIndex(result, time);
          result[index]['data'] += item['consume'];
        }
      }
      return result;
    }));
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    await DataService.instance.loadMealList();
    updateUser(AuthService.instance.currentUser!.uid);
    loadWaterdata();
    getkCalBurn();
    getkCalConsume();
    //ignore: avoid_print
    print(_user.value['uid']);
  }

  // Get user from firestore
  updateUser(String id) {
    _uid.value = id;
    getDataUser(_uid.value);
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

  double bmi() {
    return (_user.value != null)
        ? (_user.value['weight'] /
            ((_user.value['height'] / 100) * (_user.value['height'] / 100)))
        : 38.0;
  }
}

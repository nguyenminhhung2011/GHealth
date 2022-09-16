import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/tracker_controller.dart';
import 'package:flutter/material.dart';
import 'package:gold_health/constrains.dart';
import 'package:timelines/timelines.dart';

import '../../../services/auth_service.dart';

class FastingPlanController extends GetxController with TrackerController {
  var isCountDown = false.obs;
  var chooseDateTime = DateTime.now().obs;
  var isRemainMode = false.obs;
  bool isEnding = false;
  AnimationController? controllerCountDown;
  late String idFasting;
  late FastingHistory fasting;

  Rx<Map<String, FastingHistory>> fastingHistories =
      Rx<Map<String, FastingHistory>>({});

  // ignore: avoid_init_to_null
  dynamic fastingMode = null;
  List<Map<String, dynamic>> choices = [
    {
      'fastingTime': 14,
      'eatingTime': 10,
      'stars': 1,
      'badge': 'assets/images/1.PNG',
      'information': [
        '14 hours fasting',
        '10 hours eating period',
        'Great for beginners'
      ],
      'color': Colors.brown[100]!.withOpacity(0.5),
      'starColor': Colors.brown[400],
      'opacityStarColor': Colors.brown[200]!.withOpacity(0.4),
    },
    {
      'fastingTime': 16,
      'eatingTime': 8,
      'stars': 2,
      'badge': 'assets/images/2.png',
      'information': [
        '16 hours fasting',
        '8 hours eating period',
        'Suitable for intermediate level'
      ],
      'color': Colors.blue[100]!.withOpacity(0.5),
      'starColor': Colors.blue[400],
      'opacityStarColor': Colors.blue[200]!.withOpacity(0.4),
    },
    {
      'fastingTime': 18,
      'eatingTime': 6,
      'stars': 3,
      'badge': 'assets/images/3.png',
      'information': [
        '18 hours fasting',
        '6 hours eating period',
        'Suitable for advance level'
      ],
      'color': Colors.amber[100]!.withOpacity(0.5),
      'starColor': Colors.amber[400],
      'opacityStarColor': Colors.amber[200]!.withOpacity(0.4),
    },
    {
      'fastingTime': 20,
      'eatingTime': 4,
      'stars': 4,
      'badge': 'assets/images/4.png',
      'information': [
        '20 hours fasting',
        '4 hours eating period',
        'Warriors only !!!'
      ],
      'color': Colors.green[100]!.withOpacity(0.5),
      'starColor': Colors.green[400],
      'opacityStarColor': Colors.green[200]!.withOpacity(0.4),
    },
  ];

  Future<String> addFastingHistory(FastingHistory newValue) async {
    String userId = AuthService.instance.currentUser!.uid;
    final response = await firestore
        .collection('users')
        .doc(userId)
        .collection('fasting_history')
        .add(
      {
        'timeRemaining': '0',
        'startTime': Timestamp.fromDate(newValue.startTime),
        'endTime': Timestamp.fromDate(newValue.endTime),
        'saveTime': Timestamp.fromDate(newValue.saveTime),
        'name': newValue.name,
        'isFinish': newValue.isFinish,
        'isPlaying': newValue.isPlaying,
        'isSaving': newValue.isSaving,
      },
    );
    return response.id;
  }

  Future<bool> fetchDataFastingHistory() async {
    try {
      String userId = AuthService.instance.currentUser!.uid;
      final data = firestore
          .collection('users')
          .doc(userId)
          .collection('fasting_history');
      fastingHistories.bindStream(data.snapshots().map((event) {
        Map<String, FastingHistory> result = {};
        for (var doc in event.docs) {
          result.addAll({doc.id: FastingHistory.fromSnap(doc)});
        }
        return result;
      }));
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override
  void onInit() {
    int count = 0;
    fastingHistories.listen((value) {
      value.forEach((key, value) {
        if (value.isSaving && !value.isFinish) {
          print('count: $count - $key');
          isCountDown.value = true;
          fasting = value;
          idFasting = key;
          if (value.name == '14-10') {
            fastingMode = choices[0];
          } else if (value.name == '16-8') {
            fastingMode = choices[1];
          } else if (value.name == '18-6') {
            fastingMode = choices[2];
          } else {
            fastingMode = choices[3];
          }
        }
      });
    });

    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    fastingHistories.close();
  }

  Future updateHistory(String id, FastingHistory newHistory) async {
    String userId = AuthService.instance.currentUser!.uid;
    await firestore
        .collection('users')
        .doc(userId)
        .collection('fasting_history')
        .doc(id)
        .update({
      'endTime': newHistory.endTime,
      'startTime': newHistory.startTime,
      'isFinish': newHistory.isFinish,
      'isPlaying': newHistory.isPlaying,
      'isSaving': newHistory.isSaving,
      'name': newHistory.name,
      'saveTime': newHistory.saveTime,
      'timeRemaining': newHistory.timeRemaining.inSeconds.toString(),
    });
  }

  Widget timeline() {
    return Timeline.tileBuilder(
      builder: TimelineTileBuilder.connected(
        contentsAlign: ContentsAlign.basic,
        connectorBuilder: (context, index, type) {
          return Connector.dashedLine();
        },
        indicatorBuilder: (context, index) {
          switch (index) {
            case 0:
              return DotIndicator(
                color: Colors.white,
                size: 12,
                border: Border.all(color: Colors.green[400]!, width: 3),
              );
            case 1:
              return DotIndicator(
                color: Colors.white,
                size: 12,
                border: Border.all(color: Colors.amber[400]!, width: 3),
              );
          }
          return null;
        },
        contentsBuilder: (context, index) {
          switch (index) {
            case 0:
              return Row(
                children: [
                  const SizedBox(width: 5),
                  const Text(
                    'Start',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const Expanded(
                    child: Text(
                      'Today, 21:11',
                      style: TextStyle(
                          color: Color.fromARGB(255, 53, 162, 57),
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.green[50],
                      shape: const CircleBorder(),
                    ),
                    onPressed: () {
                      _showBottomSheetTimePicker();
                    },
                    child: const Icon(
                      Icons.edit,
                      size: 20,
                      color: Color.fromARGB(255, 53, 162, 57),
                    ),
                  )
                ],
              );
            case 1:
              return Row(
                children: const [
                  SizedBox(width: 5),
                  Text(
                    'End (expected)',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Expanded(
                    child: Text(
                      'Tomorrow, 11:11',
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              );
          }
          return null;
        },
        nodePositionBuilder: (context, index) => 0,
        itemExtent: 50.0,
        itemCount: 2,
      ),
    );
  }

  _showBottomSheetTimePicker() {
    double bottomSheetHeight = Get.mediaQuery.size.height * 0.37;
    return Get.bottomSheet(
      elevation: 5,
      backgroundColor: Colors.white,
      Container(
        decoration: BoxDecoration(border: Border.all(width: 2)),
        height: bottomSheetHeight,
        child: Column(
          children: [
            SizedBox(
              height: bottomSheetHeight * 0.3,
              child: CupertinoDatePicker(
                onDateTimeChanged: (value) {},
                minimumDate: DateTime.now().subtract(const Duration(days: 15)),
                maximumDate: DateTime.now().add(const Duration(days: 15)),
                initialDateTime: DateTime.now(),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),
                backgroundColor: Colors.blue[200],
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'Done',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }

  void disposeController() {}
}

class FastingHistory {
  const FastingHistory(
      {Key? key,
      required this.endTime,
      required this.isFinish,
      required this.name,
      required this.startTime,
      required this.isPlaying,
      required this.isSaving,
      required this.saveTime,
      required this.timeRemaining});

  final String name;
  final DateTime startTime;
  final DateTime endTime;
  final bool isFinish;
  final bool isPlaying;
  final bool isSaving;
  final DateTime saveTime;
  final Duration timeRemaining;

  factory FastingHistory.fromSnap(
      QueryDocumentSnapshot<Map<String, dynamic>> data) {
    final extractData = data.data();
    return FastingHistory(
      timeRemaining: Duration(seconds: int.parse(extractData['timeRemaining'])),
      isSaving: extractData['isSaving'],
      saveTime: (extractData['saveTime'] as Timestamp).toDate(),
      isPlaying: extractData['isPlaying'],
      endTime: (extractData['endTime'] as Timestamp).toDate(),
      isFinish: extractData['isFinish'],
      name: extractData['name'],
      startTime: (extractData['startTime'] as Timestamp).toDate(),
    );
  }
}

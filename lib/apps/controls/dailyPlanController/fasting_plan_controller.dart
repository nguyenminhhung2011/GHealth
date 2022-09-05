import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/tracker_controller.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class FastingPlanController extends GetxController with TrackerController {
  var isCountDown = false.obs;
  var chooseDateTime = DateTime.now().obs;
  var isRemainMode = false.obs;
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
                      primary: Colors.green[50],
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
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                primary: Colors.blue[200],
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
}

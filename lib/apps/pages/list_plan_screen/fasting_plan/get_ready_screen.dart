import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/fasting_plan_controller.dart';
import 'package:gold_health/apps/global_widgets/screenTemplate.dart';
import 'package:gold_health/apps/pages/progress_tracker/compare_result_screen.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:timelines/timelines.dart';

import '../../../template/misc/colors.dart';

class GetReadyScreen extends StatelessWidget {
  final String name;
  GetReadyScreen({Key? key, required this.name}) : super(key: key);
  var isTap = false.obs;

  final fastingPlanController = Get.find<FastingPlanController>();

  List<Map<String, dynamic>> choices = [
    {
      'name': '14-10',
      'stars': 1,
      'badge': 'assets/images/1.PNG',
      'information': ['7 days plan', 'Great for beginners'],
      'color': Colors.brown[100]!.withOpacity(0.5),
      'starColor': Colors.brown[400],
      'opacityStarColor': Colors.brown[200]!.withOpacity(0.4),
    },
    {
      'name': '16-8',
      'stars': 2,
      'badge': 'assets/images/2.png',
      'information': ['7 days plan', 'Suitable for intermediate level'],
      'color': Colors.blue[100]!.withOpacity(0.5),
      'starColor': Colors.blue[400],
      'opacityStarColor': Colors.blue[200]!.withOpacity(0.4),
    },
    {
      'name': '18-6',
      'stars': 3,
      'badge': 'assets/images/3.png',
      'information': ['7 days plan', 'Suitable for advance level'],
      'color': Colors.amber[100]!.withOpacity(0.5),
      'starColor': Colors.amber[400],
      'opacityStarColor': Colors.amber[200]!.withOpacity(0.4),
    },
    {
      'name': '20-4',
      'stars': 4,
      'badge': 'assets/images/4.png',
      'information': ['7 days plan', 'Warriors only !!!'],
      'color': Colors.green[100]!.withOpacity(0.5),
      'starColor': Colors.green[400],
      'opacityStarColor': Colors.green[200]!.withOpacity(0.4),
    },
  ];
  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: ScreenTemplate(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 5),
                const Text(
                  'Get Ready !!!',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor1.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.more_horiz,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    isTap.value = !isTap.value;
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: const CircleBorder(),
                    primary: Colors.blueGrey[50],
                  ),
                  child: Obx(
                    () => isTap.value
                        ? Icon(
                            Icons.keyboard_arrow_down,
                            size: 30,
                            color: Colors.blueGrey[400],
                          )
                        : Icon(
                            Icons.keyboard_arrow_up,
                            size: 30,
                            color: Colors.blueGrey[400],
                          ),
                  ),
                ),
              ],
            ),
            Obx(
              () => AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: isTap.value ? 200 : 0,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Icon(
                      Icons.arrow_drop_up_sharp,
                      size: 100,
                      color: Colors.blue[50],
                    ),
                    Positioned(
                      top: 50,
                      child: Container(
                        padding: const EdgeInsets.only(left: 20),
                        width: 300,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 10,
                                  color: Colors.green[400],
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  '14 hours fasting',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                      fontSize: 18),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 10,
                                  color: Colors.amber[500],
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  '10 hours eating period',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                      fontSize: 18),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 100,
              width: 300,
              child: Timeline.tileBuilder(
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
                          border:
                              Border.all(color: Colors.green[400]!, width: 3),
                        );
                      case 1:
                        return DotIndicator(
                          color: Colors.white,
                          size: 12,
                          border:
                              Border.all(color: Colors.amber[400]!, width: 3),
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
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
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
                                shape: CircleBorder(),
                                primary: Colors.green[50],
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
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            Expanded(
                              child: Text(
                                'T omorrow, 11:11',
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
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                fastingPlanController.isCountDown.value = true;
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                fixedSize: Size(widthDevice * 0.8, 55),
                primary: Colors.blue[300]!,
              ),
              child: const Text(
                'Start Fasting',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Text(
                'Try weekly plan',
                style: TextStyle(
                  color: Colors.blueGrey[600],
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: widthDevice * 0.9,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:
                    Row(children: choices.map((e) => _itemBuilder(e)).toList()),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              height: heightDevice * 0.42,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.blue[100]!.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: Colors.blueGrey[600],
                      ),
                      Text(
                        'PREPARE FOR FASTING',
                        style: TextStyle(
                            color: Colors.blueGrey[600],
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 6, right: 15),
                          child: DotIndicator(
                              color: Colors.blueGrey[600], size: 10)),
                      const Expanded(
                        child: Text(
                          'Eat enough protein, such as meat, fish, tofu and nuts.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 6, right: 15),
                          child: DotIndicator(
                              color: Colors.blueGrey[600], size: 10)),
                      const Expanded(
                        child: Text(
                            'Eat hight-fiber foods, such as nuts, beans, fruits and vegetables.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w500,
                            )),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      DotIndicator(color: Colors.blueGrey[600], size: 10),
                      const SizedBox(
                        width: 15,
                      ),
                      const Expanded(
                        child: Text(
                          'Drink plenty of water.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 6, right: 15),
                          child: DotIndicator(
                              color: Colors.blueGrey[600], size: 10)),
                      const Expanded(
                        child: Text(
                          'Fill yourself with naturals foods to help control your appetite at meal time.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _showBottomSheetTimePicker() {
    return Get.bottomSheet(
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.white,
      enableDrag: false,
      SizedBox(
        height: Get.mediaQuery.size.height * 0.4,
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: CupertinoDatePicker(
                onDateTimeChanged: (value) {},
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
      elevation: 5,
    );
  }

  Widget _itemBuilder(dynamic e) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: Get.mediaQuery.size.height * 0.2,
            width: 250,
            decoration: BoxDecoration(
              color: e['color'] as Color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      e['name'] as String,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    for (int i = 1; i <= 4; i++)
                      Icon(
                        Icons.flash_on,
                        color: i > (e['stars'] as int)
                            ? (e['opacityStarColor'] as Color)
                            : e['starColor'] as Color,
                        size: 25,
                      ),
                  ],
                ),
                const SizedBox(height: 5),
                ...(e['information'] as List<String>)
                    .map((info) => Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 10,
                              color: (e['starColor'] as Color).withOpacity(0.5),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                info,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            )
                          ],
                        ))
                    .toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

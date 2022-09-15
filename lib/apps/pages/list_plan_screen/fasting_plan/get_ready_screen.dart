import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/fasting_plan_controller.dart';
import 'package:gold_health/apps/global_widgets/screen_template.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';

import '../../../template/misc/colors.dart';

// ignore: must_be_immutable
class GetReadyScreen extends StatelessWidget {
  final Map<String, dynamic> fastingMode;
  GetReadyScreen({Key? key, required this.fastingMode}) : super(key: key);

  final fastingPlanController = Get.find<FastingPlanController>();

  var isTapExpandDetail = false.obs;

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryColor1.withOpacity(0.2),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const Text(
                    'Get Ready !!!',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
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
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${fastingMode['fastingTime']}-${fastingMode['eatingTime']}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    isTapExpandDetail.value = !isTapExpandDetail.value;
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: const CircleBorder(),
                    primary: Colors.blueGrey[50],
                  ),
                  child: Obx(
                    () => isTapExpandDetail.value
                        ? Icon(
                            Icons.keyboard_arrow_down,
                            size: 28,
                            color: Colors.blueGrey[400],
                          )
                        : Icon(
                            Icons.keyboard_arrow_up,
                            size: 28,
                            color: Colors.blueGrey[400],
                          ),
                  ),
                ),
              ],
            ),
            Obx(
              () => AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: isTapExpandDetail.value ? 200 : 0,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      top: -30,
                      child: Icon(
                        Icons.arrow_drop_up_sharp,
                        size: 100,
                        color: Colors.blue[50],
                      ),
                    ),
                    Positioned(
                      top: 20,
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
                                Text(
                                  '${fastingMode['fastingTime']} hours fasting',
                                  style: const TextStyle(
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
                                Text(
                                  '${fastingMode['eatingTime']} hours eating period',
                                  style: const TextStyle(
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
              child: CustomTimeLine(fastingMode: fastingMode),
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
                backgroundColor: AppColors.primaryColor1,
                fixedSize: Size(widthDevice * 0.8, 55),
              ),
              child: const Text(
                'Start Fasting',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  'Try weekly plan',
                  style: TextStyle(
                    color: Colors.blueGrey[600],
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: widthDevice,
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
              margin: const EdgeInsets.all(20),
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

  Widget _itemBuilder(dynamic e) {
    return Container(
      alignment: Alignment.center,
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
              mainAxisAlignment: MainAxisAlignment.center,
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

class CustomTimeLine extends StatelessWidget {
  CustomTimeLine({Key? key, this.fastingMode}) : super(key: key);
  DateTime tempDateTime = DateTime.now();

  final fastingMode;
  final fastingPlanController = Get.find<FastingPlanController>();
  @override
  Widget build(BuildContext context) {
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
                  Expanded(
                    child: Obx(() => Text(
                          DateFormat().add_E().add_jm().format(
                              fastingPlanController.chooseDateTime.value),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 53, 162, 57),
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.end,
                        )),
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
                children: [
                  const SizedBox(width: 5),
                  const Text(
                    'End (expected)',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Expanded(
                      child: Obx(
                    () => Text(
                      DateFormat().add_E().add_jm().format(
                            fastingPlanController.chooseDateTime.value.add(
                              Duration(
                                  hours: fastingMode['fastingTime'] as int),
                            ),
                          ),
                      textAlign: TextAlign.end,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  )),
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
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      Container(
        height: bottomSheetHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: bottomSheetHeight * 0.7,
              child: CupertinoDatePicker(
                onDateTimeChanged: (value) {
                  tempDateTime = value;
                },
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
                fastingPlanController.chooseDateTime.value = tempDateTime;
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

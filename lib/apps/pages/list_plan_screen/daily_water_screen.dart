import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/dailyWaterController.dart';
import 'package:gold_health/apps/pages/list_plan_screen/selectAmountFood.dart';
import 'package:gold_health/apps/pages/list_plan_screen/widgets/WaterConsumeCard.dart';
import 'package:gold_health/apps/pages/list_plan_screen/widgets/showDialogEditWater.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../global_widgets/list_chart/ColumnChart2Column.dart';
import '../../global_widgets/screenTemplate.dart';
import '../../template/misc/colors.dart';
import '../dashboard/activity_trackerScreen.dart';

class DailyWaterScreen extends StatelessWidget {
  DailyWaterScreen({Key? key}) : super(key: key);
  final _controller = Get.put(DailyWaterController());
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;

    List<String> tabs = [
      'Nutrition',
      'Workout',
      'Foot step',
      'Water',
      'Fasting',
    ];
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: ScreenTemplate(
        child: Column(
          children: [
            //App Bar
            Row(
              children: [
                InkWell(
                  onTap: () async {
                    int? newIndex;
                    await _showDialogMethod(
                      context: context,
                      tabs: tabs,
                      onselectedTabs: (value) {
                        newIndex = value;
                      },
                      done: () {
                        print(newIndex);
                        if (newIndex != null) {
                          _controller.changeTab(newIndex ?? 0);
                        } else {}
                        _controller.changeTab(0);
                        Navigator.pop(context);
                      },
                    );
                  },
                  child: Row(
                    children: const [
                      Text(
                        'Water Planner',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Colors.black,
                        size: 24,
                      )
                    ],
                  ),
                ),
                const Spacer(),
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
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  'Water consume',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                ButtonIconGradientColor(
                  title: ' Week',
                  icon: Icons.calendar_month,
                  press: () {},
                )
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: heightDevice / 2.9,
              width: double.infinity,
              child: const ColumnChartTwoColumnCustom(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'Water Consume',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.red.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'Water Target',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: widthDevice * 0.7,
                height: 1,
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Today',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichTextCustom(
                    size: 18,
                    title: 'Consume: ',
                    data: _controller.waterConsume.value,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 20,
                    width: 0.5,
                    color: Colors.grey,
                  ),
                  RichTextCustom(
                    size: 18,
                    title: 'Target: ',
                    data: _controller.waterTarget.value,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => InkWell(
                onTap: () async {
                  int targetValue = _controller.waterTarget.value;
                  int consumeValue = _controller.waterConsume.value;
                  final r = await showDialog(
                    useRootNavigator: false,
                    barrierColor: Colors.black54,
                    context: context,
                    builder: (context) => showDialogEditWater(
                      max: 2000,
                      min: 0,
                      waterConsumer: consumeValue,
                      waterTarget: targetValue,
                    ),
                  );
                  if (r != null) {
                    _controller.updateWaterTargetAndConsume(
                        r['target'], r['consume']);
                  }
                },
                child: Container(
                  height: 180.0,
                  width: 180.0,
                  child: LiquidCircularProgressIndicator(
                    value: (_controller.waterConsume.value <
                            _controller.waterTarget.value)
                        ? (_controller.waterConsume.value /
                            _controller.waterTarget.value)
                        : 1,
                    valueColor: AlwaysStoppedAnimation(
                        (_controller.waterConsume.value <
                                _controller.waterTarget.value)
                            ? AppColors.primaryColor1
                            : Colors.green.withOpacity(0.6)),
                    backgroundColor: Colors.grey.withOpacity(0.1),
                    borderWidth: 1.0,
                    borderColor: Colors.black,
                    direction: Axis.vertical,
                    center: (_controller.waterConsume.value <
                            _controller.waterTarget.value)
                        ? Text(
                            '${((_controller.waterConsume.value / _controller.waterTarget.value) * 100).round()} \%',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.check_circle, color: Colors.green),
                              SizedBox(width: 4),
                              Text(
                                'Success',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              )
                            ],
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Tap Circle to Edit Water consume and Water Target',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            Align(
              alignment: Alignment.center,
              child: Container(
                width: widthDevice * 0.7,
                height: 1,
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'History',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => _controller.waterConsumeToday.value.length > 0
                  ? Column(
                      children: _controller.waterConsumeToday.value.map((e) {
                      return WaterConsumeCard(data: e);
                    }).toList())
                  : const Text(
                      'No Water Consume Today',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  _showDialogMethod({
    required BuildContext context,
    required List<String> tabs,
    required Function(int)? onselectedTabs,
    required Function() done,
  }) async {
    await showDialog(
      useRootNavigator: false,
      barrierColor: Colors.black54,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            alignment: Alignment.center,
            height: 300,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.mainColor,
              //   color: Colors.transparent,
            ),
            child: Column(
              children: [
                Container(
                  height: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: CupertinoPicker(
                    onSelectedItemChanged: onselectedTabs,
                    selectionOverlay: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 3, color: AppColors.primaryColor1),
                      ),
                    ),
                    itemExtent: 50,
                    diameterRatio: 1.2,
                    children: [
                      for (var item in tabs)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            item,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.primaryColor1,
                  ),
                  child: ElevatedButton(
                    onPressed: done,
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Path _buildHeartPath() {
    return Path()
      ..moveTo(55, 15)
      ..cubicTo(55, 12, 50, 0, 30, 0)
      ..cubicTo(0, 0, 0, 37.5, 0, 37.5)
      ..cubicTo(0, 55, 20, 77, 55, 95)
      ..cubicTo(90, 77, 110, 55, 110, 37.5)
      ..cubicTo(110, 37.5, 110, 0, 80, 0)
      ..cubicTo(65, 0, 55, 12, 55, 15)
      ..close();
  }
}

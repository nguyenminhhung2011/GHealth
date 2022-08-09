import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/dailyWaterController.dart';
import 'package:gold_health/apps/pages/list_plan_screen/selectAmountFood.dart';
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
              child: ColumnChartTwoColumnCustom(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const RichTextCustom(
                  size: 18,
                  title: 'Consume: ',
                  data: 200,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 20,
                  width: 0.5,
                  color: Colors.grey,
                ),
                const RichTextCustom(
                  size: 18,
                  title: 'Target: ',
                  data: 4000,
                ),
              ],
            ),
            Center(
                child: SizedBox(
              height: 200,
              width: 100,
              child: CircularPercentIndicator(
                animateFromLastPercent: true,
                animationDuration: 2000,
                radius: 80,
                lineWidth: 15.0,
                percent: 0.8,
                backgroundColor: Colors.grey.withOpacity(0.2),
                progressColor: AppColors.primaryColor1,
                circularStrokeCap: CircularStrokeCap.round,
                center: Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    radius: 80,
                    onTap: () async {
                      double target_value = 300;
                      double consume_value = 3000;
                      await _showDialogEditWater(
                        context: context,
                        slideValue_target: target_value,
                        slideValue_consume: consume_value,
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor1,
                      ),
                      child: const Icon(Icons.add,
                          color: Colors.white, size: 30.0),
                    ),
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  _showDialogEditWater({
    required BuildContext context,
    required double slideValue_target,
    required double slideValue_consume,
  }) async {
    await showDialog(
      useRootNavigator: false,
      barrierColor: Colors.black54,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: 400,
            width: 120,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Water',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Target: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Slider(
                  value: slideValue_consume,
                  min: 0,
                  max: 4000,
                  divisions: 95,
                  activeColor: AppColors.primaryColor1,
                  inactiveColor: Colors.grey.withOpacity(0.2),
                  onChanged: (value) {},
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      '200ml',
                      style: TextStyle(
                        color: AppColors.primaryColor1,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                  ],
                )
              ],
            ),
          ),
        );
      },
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
                      'Learn More',
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
}

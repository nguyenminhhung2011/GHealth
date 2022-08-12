import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/dailyStep_controller.dart';
import 'package:gold_health/apps/global_widgets/screenTemplate.dart';
import 'package:gold_health/apps/pages/list_plan_screen/widgets/DataStepCard.dart';
import 'package:pedometer/pedometer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/notificationApi.dart';
import '../../global_widgets/list_chart/columnChart1Column.dart';
import '../../template/misc/colors.dart';
import '../dashboard/activity_trackerScreen.dart';

class DailyStepScreen extends StatefulWidget {
  DailyStepScreen({Key? key}) : super(key: key);

  @override
  State<DailyStepScreen> createState() => _DailyStepScreenState();
}

class _DailyStepScreenState extends State<DailyStepScreen> {
  final _controller = Get.put(DailyStepController());

  // First data
  double x = 0.0;
  double y = 0.0;
  double z = 0.0;
  double miles = 0.0;
  double duration = 0.0;
  double calories = 0.0;
  double addValue = 0.025;
  int steps = 0;
  double previousDistacne = 0.0;
  double distance = 0.0;
  bool isCount = true;

  @override
  double getValue(double x, double y, double z) {
    if (isCount) {
      double magnitude = sqrt(x * x + y * y + z * z);
      getPreviousValue();
      double modDistance = magnitude - previousDistacne;
      setPreviousValue(magnitude);
      return modDistance;
    }
    return 0;
  }

  void setPreviousValue(double distance) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setDouble("preValue", distance);
  }

  void getPreviousValue() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      previousDistacne = _pref.getDouble("preValue") ?? 0.0;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.saveData(steps, calories, miles, duration);
  }
  // void calculate data

  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;

    List<String> tabs = [
      'Nutrition',
      'Workout',
      'Foot step',
      'Water',
      'Fasting',
      'Sleep',
    ];
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: StreamBuilder<AccelerometerEvent>(
        stream: SensorsPlatform.instance.accelerometerEvents,
        builder: (context, snapShort) {
          if (snapShort.hasData) {
            x = snapShort.data!.x;
            y = snapShort.data!.y;
            z = snapShort.data!.z;
            distance = getValue(x, y, z);
            if (distance > 6) {
              steps++;
            }
            calories = _controller.calculateCalories(steps);
            duration = _controller.calculateDuration(steps);
            miles = _controller.calculateMiles(steps);
          }
          return ScreenTemplate(
            child: Column(
              children: [
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
                            } else {
                              _controller.changeTab(0);
                            }

                            Navigator.pop(context);
                          },
                        );
                      },
                      child: Row(
                        children: const [
                          Text(
                            'Foot Step Planner',
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
                      'Step Count',
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
                  height: heightDevice / 3,
                  width: double.infinity,
                  child: BarChartSample1(),
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
                const SizedBox(height: 20),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 20),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: steps.toString(),
                                style: const TextStyle(
                                    fontSize: 25, color: Colors.black),
                              ),
                              const TextSpan(
                                text: '/3000',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: AppColors.primaryColor1),
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isCount = !isCount;
                            });
                          },
                          icon: isCount
                              ? const Icon(Icons.pause,
                                  color: AppColors.primaryColor1)
                              : const Icon(Icons.play_arrow,
                                  color: AppColors.primaryColor1),
                        )
                      ],
                    ),
                    !isCount
                        ? Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.primaryColor1,
                                ),
                                child: const Text(
                                  'Stop',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: widthDevice,
                      height: 15,
                      child: LinearPercentIndicator(
                        lineHeight: 40,
                        percent: steps / 1000,
                        progressColor: AppColors.primaryColor1,
                        backgroundColor: Colors.grey.withOpacity(0.2),
                        animation: true,
                        animationDuration: 1000,
                        barRadius: const Radius.circular(20),
                      ),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: DataStepCard(
                              data: miles,
                              imagePath: 'assets/images/miles.png',
                              title: 'Miles',
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: DataStepCard(
                              data: calories,
                              imagePath: 'assets/images/calories.png',
                              title: 'Calories',
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: DataStepCard(
                              data: duration,
                              imagePath: 'assets/images/duration.png',
                              title: 'Duration',
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
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
}

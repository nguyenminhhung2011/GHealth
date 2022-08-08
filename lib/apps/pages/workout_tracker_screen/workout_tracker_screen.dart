import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/workout_plan_controller.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/widgets/CategoriesWorkoutCard.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/widgets/UpComingWorkoutContainerd.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/workout_details.dart';

import '../../global_widgets/RowText_Seemore.dart';
import '../../routes/routeName.dart';
import '../../template/misc/colors.dart';
import '../dashboard/widgets/button_gradient.dart';

class WorkoutTrackerScreen extends StatelessWidget {
  WorkoutTrackerScreen({Key? key}) : super(key: key);
  final controller = Get.put(WorkoutPlanController());
  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    List<String> tabs = [
      'Nutrition',
      'Workout',
      'Foot step',
      'Water',
      'Fasting',
    ];
    bool val = true;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            width: widthDevice,
            height: heightDevice,
            decoration: const BoxDecoration(
              color: AppColors.primaryColor1,
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: heightDevice * 0.38,
                width: widthDevice,
                child: const Padding(
                  padding: EdgeInsets.only(
                    right: 30,
                    top: 100,
                    left: 10,
                  ),
                  child: _LineChart(isShowingMainData: true),
                ),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: ListView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: heightDevice * 0.35,
                    ),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: heightDevice * 0.86),
                      child: Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 65,
                                height: 7,
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.primaryColor1.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              const SizedBox(height: 40),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 25,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: AppColors.colorGradient2,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Daily Workout Schedule',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                          ),
                                    ),
                                    const Spacer(),
                                    ButtonGradient(
                                      height: 40.0,
                                      width: 90.0,
                                      linearGradient: const LinearGradient(
                                        colors: [
                                          AppColors.primaryColor1,
                                          AppColors.primaryColor1,
                                        ],
                                      ),
                                      onPressed: () {
                                        Get.toNamed(
                                            RouteName.workoutScheduleScreen);
                                      },
                                      title: const Text(
                                        'Check',
                                        style: TextStyle(
                                          fontFamily: 'Sen',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              RowText_Seemore(
                                press: () {},
                                title: 'Upcoming Workout',
                              ),
                              const SizedBox(height: 15),
                              Column(
                                children: [
                                  UpComingWorkoutContainer(
                                    val: val,
                                    imagePath: 'assets/images/fitness.png',
                                    main: 'Fullbody Workout',
                                    time: 'Today, 03:00pm',
                                  ),
                                  const SizedBox(height: 15),
                                  UpComingWorkoutContainer(
                                    val: val,
                                    imagePath: 'assets/images/drinking.png',
                                    main: 'Uperbody Workout',
                                    time: 'June 05, 02:00pm',
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              RowText_Seemore(
                                press: () {},
                                title: 'What Do You Want to Train',
                              ),
                              const SizedBox(height: 15),
                              Column(
                                children: [
                                  CategoriesWorkoutCard(
                                    cate_name: 'Fullbody Workout',
                                    press: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              WorkoutDetailScreen(),
                                        ),
                                      );
                                    },
                                    imagePath: 'assets/images/fitness.png',
                                    exer: 11,
                                    time: 32,
                                  ),
                                  CategoriesWorkoutCard(
                                    cate_name: 'Lowebody Workout',
                                    press: () {},
                                    imagePath: 'assets/images/yoga.png',
                                    exer: 12,
                                    time: 40,
                                  ),
                                  CategoriesWorkoutCard(
                                    cate_name: 'AB Workout',
                                    press: () {},
                                    imagePath: 'assets/images/drinking.png',
                                    exer: 14,
                                    time: 20,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  const SizedBox(width: 10),
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
                            controller.changeTab(newIndex ?? 0);
                          } else {
                            controller.changeTab(0);
                          }
                          Navigator.pop(context);
                        },
                      );
                    },
                    child: Row(
                      children: const [
                        Text(
                          'Workout Planner',
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
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.more_horiz,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          )
        ],
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
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
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

class _LineChart extends StatelessWidget {
  const _LineChart({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData1,
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 1,
        maxX: 7,
        maxY: 6,
        minY: 1,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
      ];

  LineTouchData get lineTouchData2 => LineTouchData(
        enabled: false,
      );

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData2 => [];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '0%';
        break;
      case 2:
        text = '20%';
        break;
      case 3:
        text = '40%';
        break;
      case 4:
        text = '60%';
        break;
      case 5:
        text = '80%';
        break;
      case 6:
        text = '100%';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('Sun', style: style);
        break;
      case 2:
        text = const Text('Mon', style: style);
        break;
      case 3:
        text = const Text('Tue', style: style);
        break;
      case 4:
        text = const Text('Wed', style: style);
        break;
      case 5:
        text = const Text('Thu', style: style);
        break;
      case 6:
        text = const Text('Fri', style: style);
        break;
      case 7:
        text = const Text('Sat', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );
  FlGridData get gridData => FlGridData(
      show: true,
      drawVerticalLine: true,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: Colors.white,
          strokeWidth: 0.4,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: Colors.white,
          strokeWidth: 0,
        );
      });

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.white, width: 1),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: Colors.white,
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 1),
          FlSpot(2, 1.5),
          FlSpot(3, 1.4),
          FlSpot(4, 5.5),
          FlSpot(5, 2),
          FlSpot(6, 2.2),
          FlSpot(7, 1.8),
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        color: Colors.white,
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: const Color(0x00aa4cfc),
        ),
        spots: const [
          FlSpot(1, 1),
          FlSpot(2, 2.8),
          FlSpot(3, 1.2),
          FlSpot(4, 2.8),
          FlSpot(5, 2.6),
          FlSpot(6, 3.9),
          FlSpot(7, 4.9),
        ],
      );
}

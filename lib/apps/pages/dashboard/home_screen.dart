import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gold_health/apps/data/sleep_tracker_data.dart';
import 'package:time_chart/time_chart.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/workout_tracker_screen.dart';
import '../../controls/home_screen_control.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math';

import 'package:get/get.dart';
import 'package:gold_health/apps/data/fakeData.dart';
import 'package:gold_health/apps/global_widgets/GradientText.dart';
import 'package:gold_health/apps/routes/routeName.dart';
import '../../template/misc/colors.dart';
import '../mealPlanner/mealPlannerScreen.dart';
import 'widgets/button_gradient.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int touchedIndex = -1;
  double height_bmi_container = 0;
  double height_slideValue = 20;
  double weight_slideValue = 100;
  double height_process_container = 0;

  double value = 0;
  final List<int> _list = [for (int i = 1; i <= 140; i++) i];
  final homeScreenController = Get.find<HomeScreenControl>();

  final List<String> timeProgress = [
    '6am - 8am',
    '8am - 10am',
    '1pm - 3pm',
    '4pm - 5pm',
    '6pm - 8pm',
  ];
  final Map<String, double> litersProgress = {
    '6am - 8am': 600,
    '8am - 10am': 250,
    '1pm - 3pm': 500,
    '4pm - 5pm': 600,
    '11pm - 3pm': 500,
  };

  final double calories = 760;
  final double liters = 8;
  final double caloriesLeft = 230;
  final int footSteps = 1000;
  final int exerciseTime = 19;
  final int standTime = 3;

  double get sumLiters {
    double sum = 0;
    litersProgress.forEach((key, value) {
      sum += litersProgress[key] as double;
    });
    return sum;
  }

  final stopwatch = Stopwatch()..start();
  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    final double heightOfWaterChart = 100 * (timeProgress.length - 1);
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Stack(
        children: [
          Container(
            width: widthDevice,
            height: heightDevice,
            decoration: BoxDecoration(
              color: AppColors.mainColor,
            ),
            padding: const EdgeInsets.only(
              //top: 20,
              bottom: 10,
              left: 20,
              right: 20,
            ),
            // height: _heightDevice,
            // width: _widthDevice,
            child: ListView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              children: [
                Column(
                  children: [
                    ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: heightDevice * 0.86),
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(height: 20),
                            Container(
                              child: ListTile(
                                isThreeLine: true,
                                title: Text(
                                  'Welcome back',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                trailing: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Get.toNamed(
                                            RouteName.notificationScreen);
                                      },
                                      icon: Obx(
                                        () => SvgPicture.asset(
                                          homeScreenController.isNotify
                                              ? 'assets/icons/Notification-Icon_RedDot.svg'
                                              : 'assets/icons/Notification-Icon.svg',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  'Hoang Truong',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(
                                        fontSize: 24,
                                      ),
                                ),
                              ),
                            ),
                            Container(
                              // curve: Curves.fastOutSlowIn,
                              // duration: const Duration(seconds: 20),
                              padding: const EdgeInsets.only(
                                  top: 30, bottom: 10, left: 10, right: 10),

                              //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: AppColors.colorGradient1,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'BMI (Body Mass Index)',
                                            style: TextStyle(
                                              fontFamily: 'Sen',
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const Text(
                                            'You have a normal weight',
                                            style: TextStyle(
                                              fontFamily: 'Sen',
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          ButtonGradient(
                                            width: 120,
                                            height: 44,
                                            linearGradient: LinearGradient(
                                              colors: [
                                                Colors.purple[100]!,
                                                Colors.purple[200]!
                                              ],
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                height_bmi_container =
                                                    (height_bmi_container - 200)
                                                        .abs();
                                              });
                                            },
                                            title: const Text(
                                              'View More',
                                              style: TextStyle(
                                                fontFamily: 'Sen',
                                                fontSize: 12.5,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          width: 80,
                                          height: 80,
                                          child: PieChart(
                                            PieChartData(
                                              pieTouchData: PieTouchData(
                                                touchCallback:
                                                    (FlTouchEvent event,
                                                        pieTouchResponse) {
                                                  setState(() {
                                                    if (!event
                                                            .isInterestedForInteractions ||
                                                        pieTouchResponse ==
                                                            null ||
                                                        pieTouchResponse
                                                                .touchedSection ==
                                                            null) {
                                                      touchedIndex = -1;
                                                      return;
                                                    }
                                                    touchedIndex =
                                                        pieTouchResponse
                                                            .touchedSection!
                                                            .touchedSectionIndex;
                                                  });
                                                },
                                              ),
                                              startDegreeOffset: 180,
                                              borderData: FlBorderData(
                                                show: false,
                                              ),
                                              sectionsSpace: 1,
                                              centerSpaceRadius: 0,
                                              sections: FakeData.data
                                                  .asMap()
                                                  .map<int,
                                                          PieChartSectionData>(
                                                      (index, data) {
                                                    final isTouched =
                                                        index == touchedIndex;

                                                    return MapEntry(
                                                      index,
                                                      PieChartSectionData(
                                                        color: data.color,
                                                        value: data.percents,
                                                        title: (data.name ==
                                                                'now')
                                                            ? '${data.percents}'
                                                            : '',
                                                        radius:
                                                            isTouched ? 80 : 60,
                                                        titleStyle:
                                                            const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                        titlePositionPercentageOffset:
                                                            0.55,
                                                        badgeWidget: _Badge(
                                                          data.imagePath,
                                                          size: isTouched
                                                              ? 40.0
                                                              : 30.0,
                                                          borderColor:
                                                              data.color,
                                                        ),
                                                        badgePositionPercentageOffset:
                                                            .98,
                                                      ),
                                                    );
                                                  })
                                                  .values
                                                  .toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                  AnimatedContainer(
                                    curve: Curves.fastOutSlowIn,
                                    height: height_bmi_container,
                                    width: double.infinity,
                                    duration: const Duration(milliseconds: 500),
                                    decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 15,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: const [
                                                _Badge(
                                                  'assets/images/medal.png',
                                                  size: 30,
                                                  borderColor:
                                                      AppColors.primaryColor1,
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  'BMI: 38.0',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Height:  ',
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.primaryColor1,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                LoadHeightWeight(
                                                  widthDevice: widthDevice,
                                                  imgePath:
                                                      'assets/images/height.png',
                                                  fData: 120,
                                                  sData: 177,
                                                  color:
                                                      AppColors.primaryColor1,
                                                  press: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const WorkoutTrackerScreen(),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: const [
                                                SizedBox(width: 60),
                                                Text(
                                                  '160cm',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .primaryColor1,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Spacer(),
                                                Text(
                                                  '180cm',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .primaryColor1,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Weight: ',
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.primaryColor2,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                LoadHeightWeight(
                                                  widthDevice: widthDevice,
                                                  imgePath:
                                                      'assets/images/weight.png',
                                                  fData: 30,
                                                  sData: 70,
                                                  color:
                                                      AppColors.primaryColor2,
                                                  press: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const MealPlannerScreen(),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: const [
                                                SizedBox(width: 60),
                                                Text(
                                                  '60kg',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .primaryColor2,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Spacer(),
                                                Text(
                                                  '80kg',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .primaryColor2,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 25, bottom: 25),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: AppColors.colorContainerTodayTarget,
                              ),
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 10, left: 10, right: 10),
                              child: Column(
                                children: [
                                  Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Process',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                            ),
                                      ),
                                      const Spacer(),
                                      ButtonGradient(
                                        height: 40.0,
                                        width: 90.0,
                                        linearGradient: LinearGradient(
                                          colors: [
                                            Colors.blue[200]!,
                                            Colors.blue[300]!,
                                          ],
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            height_process_container =
                                                (height_process_container - 300)
                                                    .abs();
                                          });
                                        },
                                        title: const Text(
                                          'Check',
                                          style: TextStyle(
                                            fontFamily: 'Sen',
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.fastOutSlowIn,
                                    height: height_process_container,
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                'Day 1',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 17,
                                                ),
                                              ),
                                              const Spacer(),
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15,
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: AppColors
                                                          .primaryColor1),
                                                  child: const Text(
                                                    'Start Over',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: widthDevice,
                                            height: 190,
                                            child: MasonryGridView.count(
                                              crossAxisCount: 6,
                                              mainAxisSpacing: 4,
                                              crossAxisSpacing: 4,
                                              itemCount: _list.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  alignment: Alignment.center,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/calendar.png',
                                                        height: 30,
                                                        width: 30,
                                                      ),
                                                      Text(
                                                        '${_list[index]}',
                                                        style: const TextStyle(
                                                          color: AppColors
                                                              .primaryColor1,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              LoadHeightWeight(
                                                widthDevice: widthDevice *
                                                    100 /
                                                    55 *
                                                    0.7,
                                                imgePath:
                                                    'assets/images/medal.png',
                                                fData: 60,
                                                sData: 100,
                                                color: AppColors.primaryColor1,
                                                press: () {},
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: heightOfWaterChart + 600,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Activity Status',
                                    overflow: TextOverflow.clip,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          fontSize: 20,
                                        ),
                                  ),
                                  const SizedBox(height: 25),
                                  Container(
                                    height: heightDevice * 0.3,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.backGroundTableColor,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 20.0, top: 10.0),
                                          child: Text(
                                            'Sleep',
                                            style: TextStyle(
                                              fontFamily: 'Sen',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: GradientText(
                                            '8hr 20min',
                                            gradient: AppColors.colorGradient1,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: TimeChart(
                                            timeChartSizeAnimationDuration:
                                                const Duration(
                                                    milliseconds: 3000),
                                            height: heightDevice * 0.2,
                                            activeTooltip: true,
                                            data: SleepTrackerData.data,
                                            viewMode: ViewMode.weekly,
                                            barColor: AppColors.primaryColor1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  Container(
                                    height: heightDevice * 0.25,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.backGroundTableColor,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 20.0, top: 20.0),
                                          child: Text(
                                            'Heart Rate',
                                            style: TextStyle(
                                              fontFamily: 'Sen',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: GradientText(
                                            '78 BPM',
                                            gradient: AppColors.colorGradient1,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: heightDevice * 0.1,
                                          child: LineChart(
                                            LineChartData(
                                              borderData:
                                                  FlBorderData(show: false),
                                              gridData: FlGridData(show: false),
                                              titlesData:
                                                  FlTitlesData(show: false),
                                              lineTouchData: LineTouchData(
                                                enabled: true,
                                                touchTooltipData:
                                                    LineTouchTooltipData(
                                                  tooltipRoundedRadius: 20,
                                                  tooltipBgColor:
                                                      AppColors.primaryColor1,
                                                  getTooltipItems:
                                                      (List<LineBarSpot>
                                                          touchedBarSpots) {
                                                    return touchedBarSpots
                                                        .map((barSpot) {
                                                      final flSpot = barSpot;
                                                      return LineTooltipItem(
                                                        '${flSpot.x.toInt()}mins ago',
                                                        const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      );
                                                    }).toList();
                                                  },
                                                ),
                                              ),
                                              minX: 1,
                                              maxX: 30,
                                              minY: 80,
                                              maxY: 170,
                                              lineBarsData: [
                                                LineChartBarData(
                                                  spots: const [
                                                    FlSpot(1, 100),
                                                    FlSpot(2, 130),
                                                    FlSpot(3, 90),
                                                    FlSpot(4, 150),
                                                    FlSpot(5, 110),
                                                    FlSpot(6, 120),
                                                    FlSpot(7, 100),
                                                    FlSpot(8, 120),
                                                    FlSpot(9, 125),
                                                    FlSpot(10, 100),
                                                    FlSpot(11, 90),
                                                    FlSpot(12, 150),
                                                    FlSpot(13, 85),
                                                    FlSpot(14, 100),
                                                    FlSpot(15, 80),
                                                    FlSpot(16, 100),
                                                    FlSpot(17, 130),
                                                    FlSpot(18, 90),
                                                    FlSpot(19, 150),
                                                    FlSpot(20, 110),
                                                    FlSpot(21, 120),
                                                    FlSpot(22, 100),
                                                    FlSpot(23, 120),
                                                    FlSpot(24, 125),
                                                    FlSpot(25, 100),
                                                    FlSpot(26, 90),
                                                    FlSpot(27, 150),
                                                    FlSpot(28, 85),
                                                    FlSpot(29, 100),
                                                    FlSpot(30, 120),
                                                  ],
                                                  barWidth: 2,
                                                  dotData:
                                                      FlDotData(show: false),
                                                  gradient:
                                                      AppColors.colorGradient,
                                                  belowBarData: BarAreaData(
                                                    show: true,
                                                    gradient: AppColors
                                                        .colorContainerTodayTarget,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: AppColors
                                                  .colorContainerTodayTarget,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  SizedBox(
                                    height: heightOfWaterChart + 4,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 2.0,
                                                  spreadRadius: 0.0,
                                                  offset: Offset(0.5, 0.5),
                                                )
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                //height = 100 with every element
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5, right: 5),
                                                  child: RotatedBox(
                                                    quarterTurns: 3,
                                                    child:
                                                        LinearPercentIndicator(
                                                      addAutomaticKeepAlive:
                                                          true,
                                                      animationDuration: 2000,
                                                      animation: true,
                                                      width: heightOfWaterChart,
                                                      lineHeight: 22.0,
                                                      percent:
                                                          (sumLiters / 1000) /
                                                              liters,
                                                      backgroundColor:
                                                          const Color.fromARGB(
                                                              227,
                                                              224,
                                                              221,
                                                              221),
                                                      progressColor:
                                                          Colors.blue[300],
                                                      barRadius:
                                                          const Radius.circular(
                                                              20),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 12),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Water',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline4!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        18,
                                                                  ),
                                                            ),
                                                            IconButton(
                                                              onPressed: () {},
                                                              icon: Icon(
                                                                Icons
                                                                    .arrow_forward_ios_outlined,
                                                                size: 15,
                                                                color: Colors
                                                                    .grey[400],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Text(
                                                          '${sumLiters / 1000} Liters',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline2,
                                                        ),
                                                        // const SizedBox(height: 7),
                                                        const Text(
                                                          'Real time ',
                                                          style: TextStyle(
                                                            fontFamily: 'Sen',
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black45,
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: timeProgress
                                                              .map((e) {
                                                            return Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          12,
                                                                      width: 12,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        gradient:
                                                                            LinearGradient(
                                                                          colors: [
                                                                            Colors.purple[100]!,
                                                                            const Color.fromARGB(
                                                                                255,
                                                                                215,
                                                                                185,
                                                                                221),
                                                                            const Color.fromARGB(
                                                                              255,
                                                                              213,
                                                                              170,
                                                                              220,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            10),
                                                                    Text(
                                                                      e,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .headline1,
                                                                    ),
                                                                  ],
                                                                ),
                                                                if (litersProgress[
                                                                        e] !=
                                                                    null)
                                                                  Row(
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(
                                                                          left:
                                                                              5,
                                                                        ),
                                                                        child:
                                                                            DottedLine(
                                                                          lineThickness:
                                                                              1.5,
                                                                          lineLength:
                                                                              50,
                                                                          direction:
                                                                              Axis.vertical,
                                                                          dashLength:
                                                                              4.5,
                                                                          dashGradient: [
                                                                            Colors.purple[100]!,
                                                                            const Color.fromARGB(
                                                                              255,
                                                                              209,
                                                                              159,
                                                                              218,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              30),
                                                                      GradientText(
                                                                        '${litersProgress[e]}ml',
                                                                        gradient:
                                                                            AppColors.colorGradient,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )
                                                              ],
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Colors.black26,
                                                        blurRadius: 2.0,
                                                        spreadRadius: 0.0,
                                                        offset:
                                                            Offset(0.5, 0.5),
                                                      )
                                                    ],
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 22,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Activity',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline4!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        17,
                                                                  ),
                                                            ),
                                                            IconButton(
                                                                onPressed:
                                                                    () {},
                                                                icon: Icon(
                                                                  Icons
                                                                      .arrow_forward_ios_outlined,
                                                                  size: 15,
                                                                  color: Colors
                                                                          .grey[
                                                                      400],
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          RichText(
                                                            text: TextSpan(
                                                              text: 'Step',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .red[300],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12,
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      '\n$footSteps',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                    fontFamily:
                                                                        'Sen',
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                                const TextSpan(
                                                                  text: ' stp',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontFamily:
                                                                        'Sen',
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width: 60,
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5,
                                                                    right: 5),
                                                            decoration:
                                                                const BoxDecoration(
                                                              border: Border
                                                                  .symmetric(
                                                                vertical: BorderSide(
                                                                    width: 1,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            192,
                                                                            191,
                                                                            191)),
                                                              ),
                                                            ),
                                                            child: RichText(
                                                              text: TextSpan(
                                                                text:
                                                                    'Exercise',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                            .green[
                                                                        300]),
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        '\n$exerciseTime',
                                                                    style:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                  const TextSpan(
                                                                    text:
                                                                        ' min',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          RichText(
                                                            text: TextSpan(
                                                              text: 'Stand',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .blue[300],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12,
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      '\n $standTime',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                                const TextSpan(
                                                                  text: ' hr',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Expanded(
                                                        child: Center(
                                                          child:
                                                              CircularPercentIndicator(
                                                            radius:
                                                                heightOfWaterChart /
                                                                        2 -
                                                                    140,
                                                            animation: true,
                                                            animationDuration:
                                                                1800,
                                                            lineWidth: 15.0,
                                                            percent: 0.7,
                                                            center:
                                                                CircularPercentIndicator(
                                                              radius:
                                                                  heightOfWaterChart /
                                                                          2 -
                                                                      160,
                                                              animation: true,
                                                              animationDuration:
                                                                  1900,
                                                              lineWidth: 15.0,
                                                              percent: 0.5,
                                                              center:
                                                                  CircularPercentIndicator(
                                                                radius:
                                                                    heightOfWaterChart /
                                                                            2 -
                                                                        180,
                                                                animation: true,
                                                                animationDuration:
                                                                    2000,
                                                                lineWidth: 15.0,
                                                                percent: 0.3,
                                                                backgroundColor:
                                                                    const Color
                                                                            .fromARGB(
                                                                        227,
                                                                        224,
                                                                        221,
                                                                        221),
                                                                progressColor:
                                                                    Colors.blue[
                                                                        300],
                                                              ),
                                                              backgroundColor:
                                                                  const Color
                                                                          .fromARGB(
                                                                      227,
                                                                      224,
                                                                      221,
                                                                      221),
                                                              progressColor:
                                                                  Colors.green[
                                                                      300],
                                                            ),
                                                            backgroundColor:
                                                                const Color
                                                                        .fromARGB(
                                                                    227,
                                                                    224,
                                                                    221,
                                                                    221),
                                                            progressColor:
                                                                Colors.red[300],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Expanded(
                                                child: Container(
                                                  width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Colors.black26,
                                                        blurRadius: 2.0,
                                                        spreadRadius: 0.0,
                                                        offset:
                                                            Offset(0.5, 0.5),
                                                      )
                                                    ],
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 30,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Calories',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline4!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        18,
                                                                  ),
                                                            ),
                                                            IconButton(
                                                                onPressed:
                                                                    () {},
                                                                icon: Icon(
                                                                  Icons
                                                                      .arrow_forward_ios_outlined,
                                                                  size: 15,
                                                                  color: Colors
                                                                          .grey[
                                                                      400],
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                      GradientText(
                                                        '$calories kCal',
                                                        gradient: AppColors
                                                            .colorGradient1,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Center(
                                                          child:
                                                              CircularPercentIndicator(
                                                            radius:
                                                                heightOfWaterChart /
                                                                        2 -
                                                                    130,
                                                            animation: true,
                                                            animationDuration:
                                                                2000,
                                                            lineWidth: 15.0,
                                                            percent: (calories -
                                                                    caloriesLeft) /
                                                                calories,
                                                            center: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              height:
                                                                  heightOfWaterChart /
                                                                          2 -
                                                                      100,
                                                              decoration: const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: AppColors
                                                                      .btn_color),
                                                              child: Text(
                                                                '$caloriesLeft kCal left',
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'Sen',
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                            backgroundColor:
                                                                const Color
                                                                        .fromARGB(
                                                                    227,
                                                                    224,
                                                                    221,
                                                                    221),
                                                            progressColor:
                                                                Colors
                                                                    .blue[300],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoadHeightWeight extends StatelessWidget {
  const LoadHeightWeight({
    Key? key,
    required double widthDevice,
    required this.imgePath,
    required this.fData,
    required this.sData,
    required this.color,
    required this.press,
  })  : _widthDevice = widthDevice,
        super(key: key);

  final double _widthDevice;
  final String imgePath;
  final double fData;
  final double sData;
  final Color color;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Container(
              width: _widthDevice * 0.55,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primaryColor1.withOpacity(0.2),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: _widthDevice * 0.55 * (fData / sData) - 20,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                color: color,
              ),
            ),
            InkWell(
              onTap: press,
              child: _Badge(
                imgePath,
                size: 25,
                borderColor: color,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  final String svgAsset;
  final double size;
  final Color borderColor;

  const _Badge(
    this.svgAsset, {
    Key? key,
    required this.size,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Image.asset(
          svgAsset,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

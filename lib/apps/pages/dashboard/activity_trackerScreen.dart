import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gold_health/apps/data/fakeData.dart';
import 'package:gold_health/apps/global_widgets/GradientText.dart';
import 'package:gold_health/apps/global_widgets/lineChartWidget.dart';
import 'package:gold_health/apps/global_widgets/screenTemplate.dart';
import 'package:gold_health/apps/pages/dashboard/latestActi_screen.dart';
import 'package:gold_health/apps/pages/dashboard/profileScreen.dart';
import 'package:gold_health/apps/pages/dashboard/widgets/ChartBoard.dart';

import '../../global_widgets/BarChartItem.dart';
import '../../global_widgets/TargetCard.dart';
import '../../global_widgets/actiCard.dart';
import '../../global_widgets/list_chart/ColumnChart2Column.dart';
import '../../template/misc/colors.dart';

import 'package:gold_health/apps/data/sleep_tracker_data.dart';
import 'package:gold_health/apps/pages/sleep_tracker/sleep_tracker_screen.dart';
import 'package:time_chart/time_chart.dart';

class ActivityTrackerScreen extends StatelessWidget {
  const ActivityTrackerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Activity Tracker',
          style: Theme.of(context).textTheme.headline4!.copyWith(
                fontSize: 18,
                fontFamily: "Sen",
              ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.settings, color: Colors.black))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Expanded(
            //   flex: (heightDevice / 20 * 5).round(),
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 20),
            //     child: Container(
            //       width: widthDevice,
            //       padding:
            //           const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            //       decoration: BoxDecoration(
            //         //color: AppColors.primaryColor,
            //         borderRadius: BorderRadius.circular(25),
            //         gradient: AppColors.colorContainerTodayTarget,
            //       ),
            //       child: Column(
            //         children: [
            //           Expanded(
            //             flex: 2,
            //             child: Container(
            //               alignment: Alignment.center,
            //               child: Row(children: [
            //                 Text(
            //                   'Today Target',
            //                   style: TextStyle(
            //                     color: Colors.black,
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 17,
            //                   ),
            //                 ),
            //                 Spacer(),
            //                 InkWell(
            //                   borderRadius: BorderRadius.circular(15),
            //                   onTap: () {},
            //                   child: Container(
            //                     padding: const EdgeInsets.all(5),
            //                     decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(15),
            //                       color:
            //                           AppColors.primaryColor.withOpacity(0.2),
            //                     ),
            //                     child: Icon(
            //                       Icons.edit,
            //                       color: Colors.white,
            //                     ),
            //                   ),
            //                 )
            //               ]),
            //             ),
            //           ),
            //           Expanded(
            //             flex: 3,
            //             child: Container(
            //               child: Row(
            //                 children: [
            //                   TargetCard(
            //                     imagePath: 'assets/images/cup.png',
            //                     data: '8L',
            //                     targetType: 'Water Intake',
            //                   ),
            //                   const SizedBox(width: 20),
            //                   TargetCard(
            //                     imagePath: 'assets/images/shoes.png',
            //                     data: '2400',
            //                     targetType: 'Foot Steps',
            //                   )
            //                 ],
            //               ),
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // ),

            Expanded(
              // flex: (heightDevice / 20 * 15).round(),
              child: ScreenTemplate(
                child: Column(
                  children: [
                    SizedBox(
                      height: heightDevice * 0.5,
                      // padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Sleep',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                      fontSize: 17,
                                    ),
                              ),
                              const Spacer(),
                              ButtonIconGradientColor(
                                title: 'Select Week',
                                icon: Icons.calendar_month,
                                press: () {},
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SleepTrackerScreen(),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    offset: const Offset(2, 3),
                                    blurRadius: 20,
                                  ),
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    offset: const Offset(-2, -3),
                                    blurRadius: 20,
                                  )
                                ],
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const GradientText(
                                        'Week 25/7/2022 - 1/8/2022',
                                        gradient: LinearGradient(colors: [
                                          Colors.black,
                                          Colors.black
                                        ]),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Colors.grey,
                                          size: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                  const GradientText(
                                    'Average: 7hours 15minutes',
                                    gradient: LinearGradient(
                                        colors: [Colors.black, Colors.black]),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TimeChart(
                                    timeChartSizeAnimationDuration:
                                        const Duration(milliseconds: 3000),
                                    height: heightDevice * 0.3,
                                    activeTooltip: true,
                                    data: SleepTrackerData.data,
                                    viewMode: ViewMode.weekly,
                                    barColor: AppColors.primaryColor1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: heightDevice * 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 20.0),
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
                              ButtonIconGradientColor(
                                title: 'Select Week',
                                icon: Icons.calendar_month,
                                press: () {},
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          Container(
                            height: heightDevice * 0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: AppColors.backGroundTableColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  offset: const Offset(2, 3),
                                  blurRadius: 20,
                                ),
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  offset: const Offset(-2, -3),
                                  blurRadius: 20,
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: GradientText(
                                    'Week 25/7/2022 - 1/8/2022',
                                    gradient: LinearGradient(
                                        colors: [Colors.black, Colors.black]),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: GradientText(
                                    'Average: 78 BPM',
                                    gradient: LinearGradient(
                                        colors: [Colors.black, Colors.black]),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: heightDevice * 0.2,
                                  child: LineChart(
                                    LineChartData(
                                      borderData: FlBorderData(show: false),
                                      gridData: FlGridData(show: false),
                                      titlesData: FlTitlesData(show: false),
                                      lineTouchData: LineTouchData(
                                        enabled: true,
                                        touchTooltipData: LineTouchTooltipData(
                                          tooltipRoundedRadius: 20,
                                          tooltipBgColor:
                                              AppColors.primaryColor1,
                                          getTooltipItems: (List<LineBarSpot>
                                              touchedBarSpots) {
                                            return touchedBarSpots
                                                .map((barSpot) {
                                              final flSpot = barSpot;
                                              return LineTooltipItem(
                                                '${flSpot.x.toInt()}mins ago',
                                                const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
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
                                          dotData: FlDotData(show: false),
                                          gradient: AppColors.colorGradient,
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
                                      gradient:
                                          AppColors.colorContainerTodayTarget,
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Activity Progress',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    fontSize: 17,
                                  ),
                            ),
                            Spacer(),
                            ButtonIconGradientColor(
                              title: 'Select Week',
                              icon: Icons.calendar_month,
                              press: () {},
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        ChartBoard(
                            widthDevice: widthDevice,
                            heightDevice: heightDevice,
                            week: 'Week 25/7/2022 - 1/8/2022',
                            title: 'Calories burned: ',
                            data: '3000Kcal',
                            color: Colors.white)
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Calories Absorbed',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    fontSize: 17,
                                  ),
                            ),
                            Spacer(),
                            ButtonIconGradientColor(
                              title: 'Select Week',
                              icon: Icons.calendar_month,
                              press: () {},
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        ChartBoard(
                          widthDevice: widthDevice,
                          heightDevice: heightDevice,
                          week: 'Week 25/7/2022 - 1/8/2022',
                          title: 'Calories Absorbed: ',
                          data: '4000Kcal',
                          color: AppColors.primaryColor2.withOpacity(0.1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Water consumed',
                              overflow: TextOverflow.clip,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    fontSize: 17,
                                  ),
                            ),
                            Spacer(),
                            ButtonIconGradientColor(
                              title: 'Select Week',
                              icon: Icons.calendar_month,
                              press: () {},
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: heightDevice / 2.9,
                          width: double.infinity,
                          child: const ColumnChartTwoColumnCustom(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'FootSteps',
                              overflow: TextOverflow.clip,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    fontSize: 17,
                                  ),
                            ),
                            Spacer(),
                            ButtonIconGradientColor(
                              title: 'Select Week',
                              icon: Icons.calendar_month,
                              press: () {},
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        ChartBoard(
                          widthDevice: widthDevice,
                          heightDevice: heightDevice,
                          week: 'Week 25/7/2022 - 1/8/2022',
                          title: 'Number of FootSteps: ',
                          data: '300',
                          color: AppColors.mainColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Weight Trackers',
                              overflow: TextOverflow.clip,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    fontSize: 17,
                                  ),
                            ),
                            Spacer(),
                            ButtonIconGradientColor(
                              title: 'Select Days',
                              icon: Icons.calendar_month,
                              press: () {},
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: widthDevice,
                          height: heightDevice / 3,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColors.primaryColor1,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                offset: const Offset(2, 3),
                                blurRadius: 20,
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                offset: Offset(-2, -3),
                                blurRadius: 20,
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Week 25/7/2022 - 1/8/2022',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              Row(
                                children: const [
                                  Text(
                                    'Weight(kg):',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '40',
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: LineChartWidget(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Row(
                          children: [
                            Hero(
                              tag: 'latest tag',
                              child: Text(
                                'Latest Activity',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                      fontSize: 17,
                                    ),
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LatestActiScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'See more',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            ActiCard(
                              widthDevice: widthDevice,
                              imagePath: 'assets/images/drinking.png',
                              title: 'About 3 minutes ago',
                              mainTitle: 'Drinking 300ml Water',
                              press: () {},
                            ),
                            ActiCard(
                              widthDevice: widthDevice,
                              imagePath: 'assets/images/eating.png',
                              title: 'About 10 minutes ago',
                              mainTitle: 'Eat Snack (Fitbar)',
                              press: () {},
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonIconGradientColor extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() press;
  const ButtonIconGradientColor(
      {Key? key, required this.title, required this.icon, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: press,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          gradient: AppColors.colorGradient,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 5),
            Icon(icon, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class ChartCalories extends StatelessWidget {
  final double heightOfBar;
  const ChartCalories({Key? key, required this.heightOfBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: FakeData.calories.map((e) {
          return Expanded(
            child: BarChartItem(
              heightOfBar: heightOfBar,
              firstData: e['2'],
              seconData: e['1'],
            ),
          );
        }).toList(),
      ),
    );
  }
}

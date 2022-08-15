import 'package:flutter/material.dart';
import 'package:gold_health/apps/global_widgets/GradientText.dart';
import 'package:gold_health/apps/global_widgets/lineChartWidget.dart';
import 'package:gold_health/apps/global_widgets/screenTemplate.dart';
import 'package:gold_health/apps/pages/dashboard/latestActi_screen.dart';
import 'package:gold_health/apps/pages/dashboard/profileScreen.dart';

import '../../global_widgets/ButtonIconGradientColor.dart';
import '../../global_widgets/actiCard.dart';
import '../../global_widgets/list_chart/ColumnChart2Column.dart';
import '../../global_widgets/list_chart/LineHeartChart.dart';
import '../../global_widgets/list_chart/columnChart1Column.dart';
import '../../template/misc/colors.dart';

import 'package:gold_health/apps/data/sleep_tracker_data.dart';
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Expanded(
                // flex: (heightDevice / 20 * 15).round(),
                child: ScreenTemplate(
                  child: Column(
                    children: [
                      _SleepViewWeekField(heightDevice, context),
                      _HeartRateViewWeekField(heightDevice),
                      const SizedBox(height: 20),
                      _AcitvityProgreenViewWeekField(context),
                      const SizedBox(height: 20),
                      _CaloriesAbsorbedVIewWeekField(context),
                      const SizedBox(height: 20),
                      _WaterConsumedViewWeekField(context, heightDevice),
                      const SizedBox(height: 20),
                      _FootStepsViewWeekField(context),
                      const SizedBox(height: 20),
                      _WeightTrackersViewFiled(
                          context, widthDevice, heightDevice),
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
      ),
    );
  }

  Column _WeightTrackersViewFiled(
      BuildContext context, double widthDevice, double heightDevice) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Weight Trackers',
              overflow: TextOverflow.clip,
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    fontSize: 17,
                  ),
            ),
            const Spacer(),
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
    );
  }

  Column _FootStepsViewWeekField(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'FootSteps',
              overflow: TextOverflow.clip,
              style: Theme.of(context).textTheme.headline4!.copyWith(
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
          height: 320,
          width: double.infinity,
          child: ColumnChart1Column(
            week: 'Week 25/7/2022 - 1/8/2022',
            title: 'Number of FootSteps: ',
            data: '300',
            color: AppColors.primaryColor1.withOpacity(0.2),
            columnColor: AppColors.primaryColor1,
          ),
        ),
      ],
    );
  }

  Column _WaterConsumedViewWeekField(
      BuildContext context, double heightDevice) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Water consumed',
              overflow: TextOverflow.clip,
              style: Theme.of(context).textTheme.headline4!.copyWith(
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
    );
  }

  Column _CaloriesAbsorbedVIewWeekField(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Calories Absorbed',
              style: Theme.of(context).textTheme.headline4!.copyWith(
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
          height: 320,
          width: double.infinity,
          child: ColumnChart1Column(
            week: 'Week 25/7/2022 - 1/8/2022',
            title: 'Calories Absorbed: ',
            data: '4000Kcal',
            color: AppColors.primaryColor2.withOpacity(0.1),
            columnColor: AppColors.primaryColor2,
          ),
        ),
      ],
    );
  }

  Column _AcitvityProgreenViewWeekField(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Activity Progress',
              style: Theme.of(context).textTheme.headline4!.copyWith(
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
          height: 320,
          width: double.infinity,
          child: ColumnChart1Column(
            week: 'Week 25/7/2022 - 1/8/2022',
            title: 'Calories burned: ',
            data: '3000Kcal',
            color: AppColors.primaryColor.withOpacity(0.1),
            columnColor: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }

  SizedBox _HeartRateViewWeekField(double heightDevice) {
    return SizedBox(
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
                    gradient:
                        LinearGradient(colors: [Colors.black, Colors.black]),
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
                    gradient:
                        LinearGradient(colors: [Colors.black, Colors.black]),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: heightDevice * 0.2,
                  child: LineHeartChart(),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.colorContainerTodayTarget,
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
    );
  }

  SizedBox _SleepViewWeekField(double heightDevice, BuildContext context) {
    return SizedBox(
      height: heightDevice * 0.5,
      // padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Sleep',
                style: Theme.of(context).textTheme.headline4!.copyWith(
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
          Container(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    GradientText(
                      'Week 25/7/2022 - 1/8/2022',
                      gradient:
                          LinearGradient(colors: [Colors.black, Colors.black]),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                const GradientText(
                  'Average: 7hours 15minutes',
                  gradient:
                      LinearGradient(colors: [Colors.black, Colors.black]),
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
        ],
      ),
    );
  }
}

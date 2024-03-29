import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/activity_tracker_controller.dart';
import 'package:gold_health/apps/global_widgets/gradient_text.dart';
import 'package:gold_health/apps/global_widgets/list_chart/line_chart_weight.dart';
import 'package:gold_health/apps/global_widgets/screen_template.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../global_widgets/button_custom/Button_icon_gradient_color.dart';
import '../../global_widgets/acti_card.dart';
import '../../global_widgets/list_chart/colum_chart2_colum.dart';
import '../../global_widgets/list_chart/line_heart_chart.dart';
import '../../global_widgets/list_chart/colum_chart1_colum.dart';
import '../../routes/route_name.dart';
import '../../template/misc/colors.dart';

import 'package:time_chart/time_chart.dart';

class ActivityTrackerScreen extends StatelessWidget {
  ActivityTrackerScreen({Key? key}) : super(key: key);
  final activityC = Get.find<ActivityTrackerC>();
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
              onPressed: () => Get.toNamed(RouteName.profileScreen),
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
                child: GetBuilder<ActivityTrackerC>(
                    init: ActivityTrackerC(),
                    builder: (controller) {
                      return Obx(() => (controller.listSleepData.isNotEmpty &&
                              controller.listWaterData.isNotEmpty &&
                              controller.listNutriData.isNotEmpty &&
                              controller.listWeightData.isNotEmpty)
                          ? ScreenTemplate(
                              child: Column(
                                children: [
                                  _SleepViewWeekField(heightDevice, context),
                                  _HeartRateViewWeekField(heightDevice),
                                  const SizedBox(height: 20),
                                  _AcitvityProgreenViewWeekField(context),
                                  const SizedBox(height: 20),
                                  _CaloriesAbsorbedVIewWeekField(context),
                                  const SizedBox(height: 20),
                                  _WaterConsumedViewWeekField(
                                      context, heightDevice),
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
                                              print(controller.listWeightData);
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder: (context) =>
                                              //         LatestActiScreen(),
                                              //   ),
                                              // );
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
                                            imagePath:
                                                'assets/images/drinking.png',
                                            title: 'About 3 minutes ago',
                                            mainTitle: 'Drinking 300ml Water',
                                            press: () {},
                                          ),
                                          ActiCard(
                                            widthDevice: widthDevice,
                                            imagePath:
                                                'assets/images/eating.png',
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
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor1,
                                backgroundColor: Colors.white,
                              ),
                            ));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  GetBuilder<ActivityTrackerC> _WeightTrackersViewFiled(
      BuildContext context, double widthDevice, double heightDevice) {
    return GetBuilder<ActivityTrackerC>(
        init: ActivityTrackerC(),
        builder: (controller) {
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
                    press: () async {
                      await _showDatePickerWeight(
                        context: context,
                        datePick: controller.dateWeightController,
                        controller: controller,
                      );
                    },
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
                      offset: const Offset(-2, -3),
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
                      child: LineChartWidget(
                        maxData: controller.maxOfList,
                        dateTime: controller.allDateWeight.value,
                        listData: controller.listWeightData,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  // ignore: non_constant_identifier_names
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
            const Spacer(),
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
            dataColumn: const [2, 1, 12, 18, 3, 4, 5],
          ),
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  GetBuilder<ActivityTrackerC> _WaterConsumedViewWeekField(
      BuildContext context, double heightDevice) {
    return GetBuilder<ActivityTrackerC>(
        init: ActivityTrackerC(),
        builder: (controller) {
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
                  const Spacer(),
                  ButtonIconGradientColor(
                    title: 'Select Week',
                    icon: Icons.calendar_month,
                    press: () async {
                      controller.chartIndex.value = 4;
                      await _showDatePicker(
                          context: context,
                          datePicke: controller.dateWaterController,
                          controller: controller);
                    },
                  )
                ],
              ),
              const SizedBox(height: 20),
              Obx(
                () => SizedBox(
                  height: heightDevice / 2.9,
                  width: double.infinity,
                  child: ColumnChartTwoColumnCustom(
                    waterConsume: controller.waterConsumeWeek,
                    columnData: controller.maxList,
                    startDate: DateFormat()
                        .add_yMd()
                        .format(controller.startDateWater.value),
                    endDate: DateFormat()
                        .add_yMd()
                        .format(controller.finishDateWater.value),
                    barGroups: [
                      for (int i = 0; i < controller.listWaterData.length; i++)
                        controller.makeGroupData(
                            i,
                            controller.listWaterData[i]['consume'] /
                                controller.maxList *
                                19.0,
                            controller.listWaterData[i]['target'] /
                                controller.maxList *
                                19.0),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  // ignore: non_constant_identifier_names
  GetBuilder<ActivityTrackerC> _CaloriesAbsorbedVIewWeekField(
      BuildContext context) {
    return GetBuilder<ActivityTrackerC>(
      init: ActivityTrackerC(),
      builder: (controller) {
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
                const Spacer(),
                ButtonIconGradientColor(
                  title: 'Select Week',
                  icon: Icons.calendar_month,
                  press: () async {
                    controller.chartIndex.value = 3;
                    await _showDatePicker(
                        context: context,
                        datePicke: controller.dateNutriController,
                        controller: controller);
                  },
                )
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 320,
              width: double.infinity,
              child: ColumnChart1Column(
                dataColumn: [
                  for (int i = 0; i < 7; i++)
                    (controller.listNutriData[i]['kCal'] >
                            controller.listDataNutriPlan[i]['kCal'])
                        ? 20
                        : ((controller.listNutriData[i]['kCal'] /
                                controller.listDataNutriPlan[i]['kCal']) *
                            20)
                ],
                week:
                    'Week ${DateFormat().add_yMd().format(controller.startDateNutri.value)} - ${DateFormat().add_yMd().format(controller.finishDateNutri.value)}',
                title: 'Calories Absorbed: ',
                data: '4000Kcal',
                color: AppColors.primaryColor2.withOpacity(0.1),
                columnColor: AppColors.primaryColor2,
              ),
            ),
          ],
        );
      },
    );
  }

  // ignore: non_constant_identifier_names
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
            const Spacer(),
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
            dataColumn: [2, 1, 12, 20, 3, 4, 5],
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

  // ignore: non_constant_identifier_names
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
                  child: const LineHeartChart(),
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

  // ignore: non_constant_identifier_names
  GetBuilder<ActivityTrackerC> _SleepViewWeekField(
      double heightDevice, BuildContext context) {
    return GetBuilder<ActivityTrackerC>(
      init: ActivityTrackerC(),
      builder: (controller) {
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
                    press: () async {
                      controller.chartIndex.value = 0;
                      await _showDatePicker(
                          context: context,
                          datePicke: controller.dateSleepController,
                          controller: controller);
                    },
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
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GradientText(
                            'Week ${DateFormat().add_yMd().format(controller.startDateSleep.value)} - ${DateFormat().add_yMd().format(controller.finishDateSleep.value)}',
                            gradient: const LinearGradient(
                                colors: [Colors.black, Colors.black]),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
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
                    Obx(
                      () => TimeChart(
                        timeChartSizeAnimationDuration:
                            const Duration(milliseconds: 3000),
                        height: heightDevice * 0.3,
                        activeTooltip: true,
                        data: [
                          for (int i = 6; i >= 0; i--)
                            DateTimeRange(
                              start: controller.listSleepData[i]['bedTime'],
                              end: controller.listSleepData[i]['alarm'],
                            ),
                        ],
                        viewMode: ViewMode.weekly,
                        barColor: AppColors.primaryColor1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _showDatePickerWeight({
    required BuildContext context,
    required DateRangePickerController datePick,
    required ActivityTrackerC controller,
  }) async {
    await showDialog(
      useRootNavigator: false,
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: 430,
          decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              Card(
                elevation: 2,
                child: SfDateRangePicker(
                  selectionTextStyle:
                      const TextStyle(fontWeight: FontWeight.bold),
                  rangeTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                  headerStyle: const DateRangePickerHeaderStyle(
                    backgroundColor: AppColors.primaryColor1,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  monthCellStyle: const DateRangePickerMonthCellStyle(
                    textStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  selectionColor: AppColors.primaryColor1,
                  rangeSelectionColor: AppColors.primaryColor1,
                  todayHighlightColor: AppColors.primaryColor1,
                  controller: datePick,
                  view: DateRangePickerView.month,
                  selectionMode: DateRangePickerSelectionMode.range,
                  onSelectionChanged: controller.onSectionDate,
                  monthViewSettings: const DateRangePickerMonthViewSettings(
                      enableSwipeSelection: false),
                ),
              ),
              const Spacer(),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.primaryColor1,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    controller.getDataWeight();
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showDatePicker(
      {required BuildContext context,
      required DateRangePickerController datePicke,
      required ActivityTrackerC controller}) async {
    await showDialog(
      useRootNavigator: false,
      barrierColor: Colors.black54,
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 430,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.mainColor,
          ),
          child: Column(
            children: [
              Card(
                elevation: 2,
                child: SfDateRangePicker(
                  selectionTextStyle:
                      const TextStyle(fontWeight: FontWeight.bold),
                  rangeTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                  headerStyle: const DateRangePickerHeaderStyle(
                    backgroundColor: AppColors.primaryColor1,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  monthCellStyle: const DateRangePickerMonthCellStyle(
                    textStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  selectionColor: AppColors.primaryColor1,
                  rangeSelectionColor: AppColors.primaryColor1,
                  todayHighlightColor: AppColors.primaryColor1,
                  controller: datePicke,
                  view: DateRangePickerView.month,
                  selectionMode: DateRangePickerSelectionMode.range,
                  onSelectionChanged: controller.selectionChanged,
                  monthViewSettings: const DateRangePickerMonthViewSettings(
                      enableSwipeSelection: false),
                ),
              ),
              const Spacer(),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.primaryColor1,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    controller.selectDateDoneClick();
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

BarChartGroupData makeGroupData(int x, double y1, double y2) {
  return BarChartGroupData(barsSpace: 4, x: x, barRods: [
    BarChartRodData(
      toY: y1,
      color: Colors.blue.withOpacity(0.7),
      width: 7,
    ),
    BarChartRodData(
      toY: y2,
      color: Colors.red.withOpacity(0.7),
      width: 7,
    ),
  ]);
}

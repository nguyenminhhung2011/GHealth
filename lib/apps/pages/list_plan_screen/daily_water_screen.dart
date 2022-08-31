import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/pages/dashboard/activity_tracker_screen.dart';
import 'package:gold_health/apps/pages/list_plan_screen/select_amount_food.dart';
import 'package:gold_health/apps/pages/list_plan_screen/widgets/water_consume_card.dart';
import 'package:gold_health/apps/pages/list_plan_screen/widgets/show_dialog_edit_water.dart';
import 'package:intl/intl.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../controls/dailyPlanController/daily_waterController.dart';
import '../../global_widgets/button_custom/Button_icon_gradient_color.dart';
import '../../global_widgets/list_chart/colum_chart2_colum.dart';
import '../../global_widgets/screen_template.dart';
import '../../template/misc/colors.dart';

class DailyWaterScreen extends StatelessWidget {
  DailyWaterScreen({Key? key}) : super(key: key);
  final controller = Get.put(DailyWaterController());
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
      'Sleep',
    ];
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: GetBuilder<DailyWaterController>(
          init: DailyWaterController(),
          builder: (controller) {
            return ScreenTemplate(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                          onTap: () {
                            print(controller.maxList);
                          },
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
                          press: () async {
                            await _showDatePicker(context: context);
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => controller.dataChart.isNotEmpty
                          ? SizedBox(
                              height: heightDevice / 2.9,
                              width: double.infinity,
                              child: ColumnChartTwoColumnCustom(
                                columnData: controller.maxList,
                                startDate: DateFormat()
                                    .add_yMd()
                                    .format(controller.startDate.value),
                                endDate: DateFormat()
                                    .add_yMd()
                                    .format(controller.finishDate.value),
                                barGroups: [
                                  for (int i = 0;
                                      i < controller.dataChart.length;
                                      i++)
                                    controller.makeGroupData(
                                        i,
                                        controller.dataChart[i]['consume'] /
                                            controller.maxList *
                                            19.0,
                                        controller.dataChart[i]['target'] /
                                            controller.maxList *
                                            19.0),
                                ],
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.primaryColor1),
                            ),
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
                      () => controller.waterToday != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichTextCustom(
                                  size: 18,
                                  title: 'Consume: ',
                                  data: controller.waterCon,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  height: 20,
                                  width: 0.5,
                                  color: Colors.grey,
                                ),
                                RichTextCustom(
                                  size: 18,
                                  title: 'Target: ',
                                  data: controller.waterToday['target'],
                                ),
                              ],
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                color: AppColors.primaryColor1,
                              ),
                            ),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => InkWell(
                        onTap: () async {
                          int targetValue = controller.waterToday['target'];
                          int consumeValue = controller.waterCon;
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
                            controller.updateWaterTargetAndConsume(
                                r['target'], r['consume']);
                          }
                        },
                        child: SizedBox(
                          height: 180.0,
                          width: 180.0,
                          child: LiquidCircularProgressIndicator(
                            value: (controller.waterCon <
                                    controller.waterToday['target'])
                                ? (controller.waterCon /
                                    controller.waterToday['target'])
                                : 1,
                            valueColor: AlwaysStoppedAnimation(
                                (controller.waterCon <
                                        controller.waterToday['target'])
                                    ? AppColors.primaryColor1
                                    : Colors.green.withOpacity(0.6)),
                            backgroundColor: Colors.grey.withOpacity(0.1),
                            borderWidth: 1.0,
                            borderColor: Colors.black,
                            direction: Axis.vertical,
                            center: (controller.waterCon <
                                    controller.waterToday['target'])
                                ? Text(
                                    '${((controller.waterCon / controller.waterToday['target']) * 100).round()} \%',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.check_circle,
                                          color: Colors.green),
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
                      () => controller.waterCons.isNotEmpty
                          ? Column(
                              children: controller.waterCons.map((e) {
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
          }),
    );
  }

  _showDatePicker({required BuildContext context}) async {
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
                  controller: controller.dateController,
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

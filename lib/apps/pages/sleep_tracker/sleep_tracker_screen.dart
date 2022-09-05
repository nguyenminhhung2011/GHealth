import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/daily_sleep_controller.dart';
import 'package:gold_health/apps/global_widgets/screen_template.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../global_widgets/button_custom/Button_icon_gradient_color.dart';
import '../../global_widgets/list_chart/lint_chart_sleep.dart';
import '../../routes/route_name.dart';
import '../../template/misc/colors.dart';
import '../dashboard/widgets/button_gradient.dart';

class SleepTrackerScreen extends StatefulWidget {
  const SleepTrackerScreen({Key? key}) : super(key: key);

  @override
  State<SleepTrackerScreen> createState() => _SleepTrackerScreenState();
}

class _SleepTrackerScreenState extends State<SleepTrackerScreen> {
  final _controller = Get.put(DailySleepController());
  var bedTimeSwitchButton = true.obs;
  var alarmSwitchButton = true.obs;
  // ignore: unnecessary_cast

  List<String> tabs = [
    'Nutrition',
    'Workout',
    'Foot step',
    'Water',
    'Fasting',
    'Sleep',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: GetBuilder<DailySleepController>(
          init: DailySleepController(),
          builder: (controller) {
            return ScreenTemplate(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                  'Sleep Planner',
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
                              print(controller.allDateBetWeen);
                              print(controller.dataChart);
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
                      const SizedBox(height: 10),
                      Card(
                        elevation: 0,
                        child: SizedBox(
                          height: heightDevice * 0.3 + 80,
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
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
                                    press: () async {
                                      await _showDatePicker(context: context);
                                    },
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              Obx(
                                () => controller.dataChart.isNotEmpty
                                    ? ChartLoading(heightDevice, controller)
                                    : const Center(
                                        child: CircularProgressIndicator(
                                            color: AppColors.primaryColor1),
                                      ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Time Slepp Report',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Yesterday',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ...controller
                                    .listSleepReportDate(DateTime.now()
                                        .subtract(const Duration(days: 1)))
                                    .map(
                                      (e) => SleepReportItem(
                                          widthDevice: widthDevice, e: e),
                                    )
                                    .toList(),
                                const SizedBox(height: 10),
                                InkWell(
                                  onTap: () async {
                                    await Get.bottomSheet(
                                      isScrollControlled: true,
                                      enterBottomSheetDuration:
                                          const Duration(milliseconds: 100),
                                      ListReportView(controller, widthDevice),
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 20,
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'View More',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.blue[100]!.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Daily Sleep Schedule',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Sen',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ButtonGradient(
                                      height: 30,
                                      width: double.infinity,
                                      title: const Text(
                                        'Check',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      onPressed: () {
                                        Get.toNamed(RouteName.sleepSchedule);
                                      },
                                      linearGradient: LinearGradient(
                                        colors: [
                                          Colors.blue[200]!,
                                          Colors.blue[300]!,
                                          Colors.blue[400]!
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.primaryColor2.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Time Sleep Countdown',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Sen',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ButtonGradient(
                                      height: 30,
                                      width: double.infinity,
                                      title: const Text(
                                        'Start',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      onPressed: () => Get.toNamed(
                                          RouteName.selectSleepTime),
                                      linearGradient: LinearGradient(
                                        colors: [
                                          AppColors.primaryColor2,
                                          AppColors.primaryColor2
                                              .withOpacity(0.6),
                                          AppColors.primaryColor2
                                              .withOpacity(0.3)
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Today Schedule',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Obx(
                        () => Column(
                          children: [
                            ...controller.listSleepToday.map((e) {
                              return Column(
                                children: [
                                  controller.itemBuilder(
                                      e, widthDevice, context),
                                ],
                              );
                            }).toList(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  // ignore: non_constant_identifier_names
  SizedBox ChartLoading(double heightDevice, DailySleepController controller) {
    return SizedBox(
      height: heightDevice * 0.3 + 10,
      child: LineChartSleep(
        data: [
          FlSpot(
              1.0,
              (controller.dataChart[6]['data'] != 0)
                  ? (controller.dataChart[6]['data'] / 3600) /
                      ((controller.maxList / 3600).round()) *
                      2
                  : 0),
          for (int i = 1; i <= controller.dataChart.length - 1; i++)
            FlSpot(
                (i + 1) * 1.0,
                (controller.dataChart[i]['data'] != 0.0)
                    ? (controller.dataChart[i]['data'] / 3600) /
                        ((controller.maxList / 3600).round()) *
                        2
                    : 0)
        ],
        columnData: (controller.maxList / 3600).round(),
      ),
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
                  controller: _controller.dateController,
                  view: DateRangePickerView.month,
                  selectionMode: DateRangePickerSelectionMode.range,
                  onSelectionChanged: _controller.selectionChanged,
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
                    _controller.selectDateDoneClick();
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

  Container ListReportView(
      DailySleepController controller, double widthDevice) {
    return Container(
      margin: const EdgeInsets.only(top: 100),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.close, color: Colors.black),
              onPressed: () => Get.back(),
            ),
            centerTitle: true,
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'List Sleep Time Report',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  ...controller.listSleepReport
                      .map(
                        (e) => SleepReportItem(widthDevice: widthDevice, e: e),
                      )
                      .toList(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names

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

class SleepReportItem extends StatelessWidget {
  const SleepReportItem({
    Key? key,
    required this.widthDevice,
    required this.e,
  }) : super(key: key);

  final double widthDevice;
  final Map<String, dynamic> e;

  formatedTime({required int timeInSecond}) {
    int h, m, s;
    h = timeInSecond ~/ 3600;
    m = ((timeInSecond - h * 3600)) ~/ 60;
    s = timeInSecond - (h * 3600) - (m * 60);
    String result = "${h}h:${m}m";
    return result;
  }

  Widget build(BuildContext context) {
    return Container(
      width: widthDevice * 0.9,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor1.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              '${DateFormat().add_yMd().format(e['bedTime'])} ~ ${DateFormat().add_yMd().format(e['alarm'])} ',
              style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/images/bed.png'),
              Container(
                height: 40,
                width: 1,
                color: Colors.grey,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Bed Time \n',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    TextSpan(
                      text: DateFormat().add_jm().format(e['bedTime']),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Image.asset('assets/images/duration.png',
                      height: 20, width: 20),
                  Text(
                    formatedTime(timeInSecond: e['goal']),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  )
                ],
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Alarm Goff \n',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    TextSpan(
                      text: DateFormat().add_jm().format(e['alarm']),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Container(
                height: 40,
                width: 1,
                color: Colors.grey,
              ),
              Image.asset('assets/images/Icon-Alaarm.png'),
            ],
          ),
        ],
      ),
    );
  }
}

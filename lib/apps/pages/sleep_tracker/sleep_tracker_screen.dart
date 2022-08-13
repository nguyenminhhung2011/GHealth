import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/dailySleep_controller.dart';
import 'package:gold_health/apps/global_widgets/ToggleButtonIos.dart';
import 'package:gold_health/apps/global_widgets/screenTemplate.dart';
import 'package:gold_health/apps/pages/sleep_tracker/sleep_schedule_screen.dart';
import 'package:intl/intl.dart';

import '../../../main.dart';
import '../../../services/notificationApi.dart';
import '../../template/misc/colors.dart';
import '../dashboard/activity_trackerScreen.dart';
import '../dashboard/widgets/button_gradient.dart';
import 'package:timezone/timezone.dart' as tz;

class SleepTrackerScreen extends StatefulWidget {
  const SleepTrackerScreen({Key? key}) : super(key: key);

  @override
  State<SleepTrackerScreen> createState() => _SleepTrackerScreenState();
}

class _SleepTrackerScreenState extends State<SleepTrackerScreen> {
  final _controller = Get.put(DailySleepController());
  int touchedIndex = -1;
  var bedTimeSwitchButton = true.obs;
  var alarmSwitchButton = true.obs;
  // ignore: unnecessary_cast
  var listSchedule = ([
    {
      'name': 'Bedtime',
      'icon': 'assets/images/bed.png',
      'time': DateTime(2022, 8, 5, 21),
      'isTurnOn': true,
    },
    {
      'name': 'Alarm',
      'icon': 'assets/images/Icon-Alaarm.png',
      'time': DateTime(2022, 8, 5, 5, 10),
      'isTurnOn': true,
    },
  ] as List<Map<String, dynamic>>)
      .obs;

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

  Widget itemBuilder(Map<String, dynamic> element, double widthDevice) {
    DateTime time = element['time'] as DateTime;
    int hour = (DateTime.now().hour - time.hour).abs();
    int minute = (DateTime.now().minute - time.minute).abs();
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 100,
      width: widthDevice * 0.9,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 240, 248, 251),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        isThreeLine: true,
        leading: Image.asset(element['icon'] as String),
        title: RichText(
          text: TextSpan(
            text: '${element['name'] as String}, ',
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Sen',
              fontSize: 19,
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                  text: "${DateFormat().add_jm().format(time)} ",
                  style: const TextStyle(
                      fontFamily: 'Sen',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54)),
            ],
          ),
        ),
        subtitle: Container(
          margin: const EdgeInsets.only(top: 10),
          child: RichText(
            text: TextSpan(
              text: 'in ',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
              children: [
                TextSpan(
                  text: '$hour',
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600]),
                ),
                TextSpan(
                  text: 'hours ',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
                TextSpan(
                  text: '$minute',
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600]),
                ),
                TextSpan(
                  text: 'minutes',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {},
              child: const Icon(
                Icons.more_vert,
                size: 20,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 20,
              child: ToggleButtonIos(val: element['isTurnOn'] as bool),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(var widthDevice) {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched
          ? (widthDevice as double) * 0.18
          : (widthDevice as double) * 0.15;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue[300],
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.amber[300],
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color.fromARGB(255, 108, 39, 176).withOpacity(0.6),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green[300],
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
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

  Widget rightTitleWidget(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('0h', style: style);
        break;
      case 1:
        text = const Text('1h', style: style);
        break;
      case 2:
        text = const Text('2h', style: style);
        break;
      case 3:
        text = const Text('3h', style: style);
        break;
      case 4:
        text = const Text('4h', style: style);
        break;
      case 5:
        text = const Text('5h', style: style);
        break;
      case 6:
        text = const Text('6h', style: style);
        break;
      case 7:
        text = const Text('7h', style: style);
        break;
      case 8:
        text = const Text('8h', style: style);
        break;
      case 9:
        text = const Text('9h', style: style);
        break;
      case 10:
        text = const Text('10h', style: style);
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

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ScreenTemplate(
        child: SafeArea(
          child: Center(
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
                const SizedBox(height: 10),
                Card(
                  elevation: 0,
                  child: Container(
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
                              press: () {
                                print(1);
                                // scheduleAlarm(DateTime.now(),
                                //     isRepeating: true);
                              },
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          height: heightDevice * 0.3 + 10,
                          child: LineChart(
                            LineChartData(
                              borderData: FlBorderData(show: false),
                              gridData: FlGridData(
                                  show: false,
                                  getDrawingHorizontalLine: (value) {
                                    return FlLine(
                                      color: Colors.black,
                                      strokeWidth: 0.4,
                                    );
                                  },
                                  getDrawingVerticalLine: (value) {
                                    return FlLine(
                                      color: Colors.black,
                                      strokeWidth: 0,
                                    );
                                  }),
                              titlesData: FlTitlesData(
                                show: true,
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                      reservedSize: 32,
                                      interval: 1,
                                      showTitles: true,
                                      getTitlesWidget: rightTitleWidget),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 32,
                                    interval: 1,
                                    getTitlesWidget: bottomTitleWidgets,
                                  ),
                                ),
                              ),
                              lineTouchData: LineTouchData(
                                enabled: true,
                                touchTooltipData: LineTouchTooltipData(
                                  tooltipRoundedRadius: 20,
                                  tooltipBgColor: Colors.white,
                                  getTooltipItems:
                                      (List<LineBarSpot> touchedBarSpots) {
                                    return touchedBarSpots.map((barSpot) {
                                      final flSpot = barSpot;
                                      return LineTooltipItem(
                                        '43% increase',
                                        const TextStyle(
                                          color: Colors.green,
                                        ),
                                      );
                                    }).toList();
                                  },
                                ),
                              ),
                              minX: 1,
                              maxX: 7,
                              minY: 0,
                              maxY: 8,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: const [
                                    FlSpot(1, 7),
                                    FlSpot(2, 6),
                                    FlSpot(3, 8),
                                    FlSpot(4, 6),
                                    FlSpot(5, 8),
                                    FlSpot(6, 6.5),
                                    FlSpot(7, 7.5),
                                  ],
                                  barWidth: 2,
                                  dotData: FlDotData(show: false),
                                  gradient: AppColors.colorGradient,
                                  isCurved: true,
                                  belowBarData: BarAreaData(
                                    show: true,
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Color.fromARGB(255, 187, 216, 239)
                                            .withOpacity(0.08),
                                        Color.fromARGB(255, 187, 216, 239)
                                            .withOpacity(0.1),
                                        Color.fromARGB(255, 187, 216, 239)
                                            .withOpacity(0.2),
                                        Color.fromARGB(255, 187, 216, 239)
                                            .withOpacity(0.4),
                                        Color.fromARGB(255, 187, 216, 239)
                                            .withOpacity(0.5),
                                        Color.fromARGB(255, 187, 216, 239)
                                            .withOpacity(0.7),
                                        Color.fromARGB(255, 187, 216, 239)
                                            .withOpacity(0.8),
                                        Color.fromARGB(255, 187, 216, 239)
                                            .withOpacity(0.9),
                                        Color.fromARGB(255, 187, 216, 239)
                                            .withOpacity(1),
                                      ],
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
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 0,
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      const Text(
                        'Your last night time analyst',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: heightDevice * 0.35,
                            width: widthDevice * 0.6,
                            child: PieChart(
                              PieChartData(
                                  pieTouchData: PieTouchData(
                                    touchCallback:
                                        (flTouchEvent, pieTouchResponse) {
                                      setState(() {
                                        if (!flTouchEvent
                                                .isInterestedForInteractions ||
                                            pieTouchResponse == null ||
                                            pieTouchResponse.touchedSection ==
                                                null) {
                                          touchedIndex = -1;
                                          return;
                                        }
                                        touchedIndex = pieTouchResponse
                                            .touchedSection!
                                            .touchedSectionIndex;
                                      });
                                    },
                                  ),
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 40,
                                  sections: showingSections(widthDevice)),
                              swapAnimationDuration:
                                  const Duration(milliseconds: 300),
                              swapAnimationCurve: Curves.ease,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.square, color: Colors.blue[300]),
                                    const Text('Awake'),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(Icons.square,
                                        color: Colors.amber[300]),
                                    const Text('REM'),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(Icons.square,
                                        color: const Color.fromARGB(
                                                255, 108, 39, 176)
                                            .withOpacity(0.6)),
                                    const Text('Core'),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(Icons.square,
                                        color: Colors.green[300]),
                                    const Text(
                                      'Deep',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue[100]!.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: heightDevice * 0.08,
                  width: widthDevice * 0.9,
                  child: ListTile(
                    leading: const Text(
                      'Daily Sleep Schedule',
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: ButtonGradient(
                        height: 35,
                        width: 80,
                        title: const Text(
                          'Check',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        onPressed: () {
                          Navigator.of(context).push<void>(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  SleepScheduleScreen(
                                      itemBuilder: itemBuilder,
                                      listSchedule: listSchedule),
                            ),
                          );
                        },
                        linearGradient: LinearGradient(colors: [
                          Colors.blue[200]!,
                          Colors.blue[300]!,
                          Colors.blue[400]!
                        ])),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Today Schedule',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 15),
                Obx(
                  () => Column(
                    children: [
                      ...(listSchedule.value).map((element) {
                        return itemBuilder(element, widthDevice);
                      }).toList(),
                    ],
                  ),
                )
              ],
            ),
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

  // void scheduleAlarm(DateTime scheduledNotificationDateTime,
  //     {required bool isRepeating}) async {
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     'alarm_notif',
  //     'alarm_notif',
  //     channelDescription: 'Channel for Alarm notification',
  //     icon: 'codex_logo',
  //     sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
  //     largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
  //   );

  //   var iOSPlatformChannelSpecifics = IOSNotificationDetails(
  //     sound: 'a_long_cold_sting.wav',
  //     presentAlert: true,
  //     presentBadge: true,
  //     presentSound: true,
  //   );
  //   var platformChannelSpecifics = NotificationDetails(
  //     android: androidPlatformChannelSpecifics,
  //     iOS: iOSPlatformChannelSpecifics,
  //   );

  //   if (isRepeating)
  //     await flutterLocalNotificationsPlugin.showDailyAtTime(
  //       0,
  //       'Office',
  //       'OK',
  //       Time(
  //         scheduledNotificationDateTime.hour,
  //         scheduledNotificationDateTime.minute,
  //         scheduledNotificationDateTime.second,
  //       ),
  //       platformChannelSpecifics,
  //     );
  //   else
  //     await flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       'Office',
  //       'Ok',
  //       tz.TZDateTime.from(scheduledNotificationDateTime, tz.local),
  //       platformChannelSpecifics,
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime,
  //     );
  // }

  // void onSaveAlarm(bool _isRepeating) {
  //   DateTime? scheduleAlarmDateTime;
  //   if (_alarmTime!.isAfter(DateTime.now()))
  //     scheduleAlarmDateTime = _alarmTime;
  //   else
  //     scheduleAlarmDateTime = _alarmTime!.add(Duration(days: 1));

  //   var alarmInfo = AlarmInfo(
  //     alarmDateTime: scheduleAlarmDateTime,
  //     gradientColorIndex: _currentAlarms!.length,
  //     title: 'alarm',
  //   );
  //   _alarmHelper.insertAlarm(alarmInfo);
  //   if (scheduleAlarmDateTime != null) {
  //     scheduleAlarm(scheduleAlarmDateTime, alarmInfo,
  //         isRepeating: _isRepeating);
  //   }
  //   Navigator.pop(context);
  //   loadAlarms();
  // }

  // void deleteAlarm(int? id) {
  //   _alarmHelper.delete(id);
  //   //unsubscribe for notification
  //   loadAlarms();
  // }
}

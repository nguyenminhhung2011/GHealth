import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/global_widgets/dialog/success_dialog.dart';
import 'package:gold_health/apps/global_widgets/dialog/yes_no_dialog.dart';
import 'package:gold_health/apps/global_widgets/screen_template.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../controls/dailyPlanController/daily_sleep_controller.dart';
import '../../template/misc/colors.dart';

class SleepCounting extends StatefulWidget {
  SleepCounting({Key? key}) : super(key: key);

  @override
  State<SleepCounting> createState() => _SleepCountingState();
}

class _SleepCountingState extends State<SleepCounting>
    with TickerProviderStateMixin {
  final controller = Get.find<DailySleepController>();
  var isBedTimeExpanded = false.obs;
  var isAlarmExnpanded = false.obs;
  final now = DateTime.now();
  final later = DateTime.now().add(const Duration(days: 1));
  RxBool isStart = false.obs;
  Rx<DateTime> choseBedTime = DateTime.now().obs;
  Rx<DateTime> choseAlarm = DateTime.now().obs;
  Rx<int> currentTime = 1.obs;
  AnimationController? controllerCurrentTime;
  double progress = 0;
  onComPleted() async {
    final update = await controller.updateGoalSleepReport(currentTime.value);
    if (update == 'Success') {
      controller.disposePickTime();
      final r = await Get.dialog(const SuccessDialog(
          question: 'Congratulations on completing your sleep',
          title1: 'Have a goodday'));
      if (r == true) {
        Get.back();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    currentTime.value =
        controller.intervalBedTime.h * 3600 + controller.intervalBedTime.m * 60;
    choseBedTime.value = DateTime(now.year, now.month, now.day,
        controller.inBedTime.h, controller.inBedTime.m, 0);
    choseAlarm.value = DateTime(later.year, later.month, later.day,
        controller.outBedTime.h, controller.outBedTime.m, 0);
    controllerCurrentTime = AnimationController(
        vsync: this, duration: Duration(seconds: currentTime.value));
    controllerCurrentTime!.forward(from: controllerCurrentTime!.value);
    controllerCurrentTime!.stop();
    controllerCurrentTime!.addListener(() {
      setState(() {
        progress = controllerCurrentTime!.value;
      });
    });
    controllerCurrentTime!.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.forward:
          break;
        case AnimationStatus.completed:
          onComPleted();
          break;
        default:
          break;
      }
    });
  }

  @override
  void dispose() {
    if (controllerCurrentTime != null) {
      controllerCurrentTime?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/sleepbackground.png'),
              ),
            ),
          ),
          ScreenTemplate(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                      onTap: () async {
                        isStart.value = false;
                        controllerCurrentTime!.stop();
                        final update = await controller.updateGoalSleepReport(
                            (progress * currentTime.value).round());
                        if (update == 'Success') {
                          final r = await Get.dialog(YesNoDialog(
                              press: () {
                                controller.disposePickTime();
                                Get.back(result: true);
                              },
                              question: 'Do you want exist sleep counting?',
                              title1: 'Your progress will be saved in the data',
                              title2: ''));
                          if (r == true) {
                            Get.back();
                          }
                        }
                      },
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.close, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Good Night',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '20 : 30',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CircularPercentIndicator(
                      center: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Image.asset('assets/images/centerSleep.png',
                            height: 120, width: 120),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      percent: progress,
                      // reverse: fastingPlanController.isRemainMode.value,
                      curve: Curves.linear,
                      progressColor: AppColors.primaryColor,
                      backgroundColor: Colors.blueGrey.withOpacity(0.3),
                      lineWidth: 7,
                      radius: 150,
                      backgroundWidth: 9,
                      onAnimationEnd: () {},
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 180,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.primaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.timelapse, color: Colors.white),
                          const SizedBox(width: 5),
                          Text(DateFormat().add_jm().format(choseAlarm.value),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Obx(
                              () => AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.linear,
                                height: isBedTimeExpanded.value ? 220 : 100,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.primaryColor,
                                          ),
                                          child: const Icon(
                                              Icons.single_bed_sharp,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(width: 5),
                                        const Text(
                                          'Bed Time',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Obx(
                                          () => Text(
                                            DateFormat()
                                                .add_jm()
                                                .format(choseBedTime.value),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Obx(
                              () => AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.linear,
                                height: isAlarmExnpanded.value ? 220 : 100,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.primaryColor,
                                          ),
                                          child: const Icon(Icons.alarm,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(width: 5),
                                        const Text(
                                          'Alarm Goff',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Obx(
                                      () => Text(
                                        DateFormat()
                                            .add_jm()
                                            .format(choseAlarm.value),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle,
                              size: 35, color: AppColors.primaryColor),
                          const SizedBox(width: 10),
                          const Text(
                            'Sleep Goal',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${NumberFormat('00').format(controller.intervalBedTime.h)}Hr ${NumberFormat('00').format(controller.intervalBedTime.m)}Min',
                            style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      // padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.primaryColor,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (isStart.value) {
                            controller.updateGoalSleepReport(
                                (progress * currentTime.value).round());
                          }
                          isStart.value = !isStart.value;
                          (isStart.value)
                              ? controllerCurrentTime!
                                  .forward(from: controllerCurrentTime!.value)
                              : controllerCurrentTime!.stop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          alignment: Alignment.center,
                          fixedSize: const Size(double.infinity, 45),
                          elevation: 0,
                        ),
                        child: Obx(
                          () => Text(
                            !isStart.value ? 'Start Sleeping' : 'Awake ',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

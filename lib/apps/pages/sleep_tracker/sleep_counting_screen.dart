import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/global_widgets/screen_template.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../template/misc/colors.dart';

class SleepCounting extends StatefulWidget {
  SleepCounting({Key? key}) : super(key: key);

  @override
  State<SleepCounting> createState() => _SleepCountingState();
}

class _SleepCountingState extends State<SleepCounting> {
  var isBedTimeExpanded = false.obs;
  var isAlarmExnpanded = false.obs;
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
                      onTap: () => Get.back(),
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
                      percent: 0.4,
                      // reverse: fastingPlanController.isRemainMode.value,
                      curve: Curves.linear,
                      progressColor: AppColors.primaryColor,
                      backgroundColor: Colors.blueGrey.withOpacity(0.3),
                      lineWidth: 7,
                      radius: 150,
                      backgroundWidth: 9,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 130,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.primaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.timelapse, color: Colors.white),
                          SizedBox(width: 5),
                          Text('4:30',
                              style: TextStyle(
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
                                        const Text(
                                          '10:00 PM',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            isBedTimeExpanded.value =
                                                !isBedTimeExpanded.value;
                                          },
                                          child: const Icon(
                                            Icons.change_circle,
                                            size: 25,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (isBedTimeExpanded.value)
                                      FutureBuilder(
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            return SizedBox(
                                              height: 100,
                                              child: CupertinoTimerPicker(
                                                mode:
                                                    CupertinoTimerPickerMode.hm,
                                                onTimerDurationChanged:
                                                    (value) {},
                                              ),
                                            );
                                          } else {
                                            return const SizedBox();
                                          }
                                        },
                                        future: Future.delayed(
                                            const Duration(milliseconds: 550)),
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          '5:00 AM PM',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            isAlarmExnpanded.value =
                                                !isAlarmExnpanded.value;
                                          },
                                          child: const Icon(
                                            Icons.change_circle,
                                            size: 25,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (isAlarmExnpanded.value)
                                      FutureBuilder(
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            return SizedBox(
                                              height: 100,
                                              child: CupertinoTimerPicker(
                                                mode:
                                                    CupertinoTimerPickerMode.hm,
                                                onTimerDurationChanged:
                                                    (value) {},
                                              ),
                                            );
                                          } else {
                                            return const SizedBox();
                                          }
                                        },
                                        future: Future.delayed(
                                            const Duration(milliseconds: 550)),
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
                        children: const [
                          Icon(Icons.check_circle,
                              size: 35, color: AppColors.primaryColor),
                          SizedBox(width: 10),
                          Text(
                            'Sleep Goal',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '8',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Text(
                            'h',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.primaryColor,
                      ),
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            fixedSize: const Size(110, 20),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Start Sleep',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
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

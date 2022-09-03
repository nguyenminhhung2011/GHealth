import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/global_widgets/screen_template.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../template/misc/colors.dart';

class SleepCounting extends StatelessWidget {
  SleepCounting({Key? key}) : super(key: key);

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
                    const SizedBox(height: 10),
                    Row(
                      children: [],
                    ),
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

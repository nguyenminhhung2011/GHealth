import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/fasting_plan_controller.dart';
import 'package:gold_health/apps/global_widgets/screenTemplate.dart';
import 'package:gold_health/apps/pages/list_plan_screen/fasting_plan/count_down_timer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:timelines/timelines.dart';

import '../../../global_widgets/YesNoDialog.dart';

class FastingCountdownScreen extends StatefulWidget {
  const FastingCountdownScreen({Key? key, required this.timeline})
      : super(key: key);
  final Widget timeline;
  @override
  State<FastingCountdownScreen> createState() => _FastingCountdownScreenState();
}

class _FastingCountdownScreenState extends State<FastingCountdownScreen> {
  final fastingPlanController = Get.find<FastingPlanController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _itemBuilderCircularIndicator(
                    'assets/images/blood.png', '0h - 2h', 0.3),
                _itemBuilderCircularIndicator(
                    'assets/images/calories_icon_fasting.png', '250 kcal', 0.7),
                _itemBuilderCircularIndicator(
                    'assets/images/water-drop.png', '2.5 lit', 0.8),
                _itemBuilderReel('assets/images/ask_question.png'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        CountDownTimer(
          duration: Duration(
              hours: (fastingPlanController.fastingMode
                  as Map<String, dynamic>)['fastingTime'] as int),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            Get.to(
              () => Scaffold(
                body: ScreenTemplate(
                    child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: Get.mediaQuery.size.width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => Get.back(),
                              child: const Icon(
                                Icons.arrow_back_ios_new_outlined,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              'Change your plan',
                              style: TextStyle(
                                color: Colors.blueGrey[600],
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 1),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      ...fastingPlanController.choices
                          .map(
                            (e) => Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: Material(
                                borderRadius: BorderRadius.circular(20),
                                elevation: 5,
                                color: Colors.white,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    fastingPlanController.fastingMode = e;
                                    Get.back();
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    height: Get.mediaQuery.size.height * 0.2,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: e['color'] as Color,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${e['fastingTime']}-${e['eatingTime']}',
                                              style: const TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            for (int i = 1; i <= 4; i++)
                                              Icon(
                                                Icons.flash_on,
                                                color: i > (e['stars'] as int)
                                                    ? (e['opacityStarColor']
                                                        as Color)
                                                    : e['starColor'] as Color,
                                                size: 25,
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        ...(e['information'] as List<String>)
                                            .map((info) => Row(
                                                  children: [
                                                    Icon(
                                                      Icons.circle,
                                                      size: 10,
                                                      color: (e['starColor']
                                                              as Color)
                                                          .withOpacity(0.5),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Text(
                                                      info,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16),
                                                    )
                                                  ],
                                                ))
                                            .toList(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                )),
              ),
              transition: Transition.downToUp,
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            height: 40,
            width: 90,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${(fastingPlanController.fastingMode as Map<String, dynamic>)['fastingTime'] as int}-${(fastingPlanController.fastingMode as Map<String, dynamic>)['eatingTime'] as int}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey[300],
                  ),
                ),
                Icon(
                  Icons.edit_outlined,
                  color: Colors.blueGrey[300],
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        /////
        SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: widget.timeline,
            )),
        /////
        const SizedBox(height: 20),
        Container(
          height: Get.mediaQuery.size.height * 0.18,
          width: Get.mediaQuery.size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.amber[100],
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Text(
                'You\'re are not really hungry',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Text(
                  'Sometimes, you may feel hunger when you are dehydrated.',
                  style: TextStyle(
                    color: Colors.blueGrey[400],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: Text(
                  'You can drink some water and see if the hunger disappears.',
                  style: TextStyle(
                    color: Colors.blueGrey[400],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: Get.mediaQuery.size.height * 0.25,
          width: Get.mediaQuery.size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: Colors.green[100]!.withOpacity(0.5),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: Colors.blueGrey[600],
                  ),
                  Text(
                    'During Fasting',
                    style: TextStyle(
                        color: Colors.blueGrey[600],
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 6, right: 15),
                      child:
                          DotIndicator(color: Colors.blueGrey[600], size: 10)),
                  const Expanded(
                    child: Text(
                      'Drink water or herbal tea to stay hydrated.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 6, right: 15),
                      child:
                          DotIndicator(color: Colors.blueGrey[600], size: 10)),
                  const Expanded(
                    child: Text('Keep your mind off food.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                        )),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  DotIndicator(color: Colors.blueGrey[600], size: 10),
                  const SizedBox(
                    width: 15,
                  ),
                  const Expanded(
                    child: Text(
                      'Avoid hight-intensity workouts.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ElevatedButton(
            onPressed: () {
              Get.dialog(
                YesNoDialog(
                  press: () {
                    fastingPlanController.fastingMode = null;
                    Get.back();
                    fastingPlanController.isCountDown.value = false;
                  },
                  question: 'End fasting ?',
                  title1: 'You haven\'t finish your goal yet.',
                  title2: 'Are you sure you want to end fasting early ?',
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(width: 2, color: Colors.deepOrange)),
              alignment: Alignment.center,
              elevation: 0,
              fixedSize: Size(Get.mediaQuery.size.width, 70),
            ),
            child: const Text(
              'End fasting',
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  _itemBuilderReel(String reelAssets) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Container(
          height: 150,
          width: 120,
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: Image.asset(
                  'assets/images/ask_question.png',
                  fit: BoxFit.fill,
                  height: 110,
                  width: 150,
                ),
              ),
              const SizedBox(height: 5),
              const Expanded(
                child: Text(
                  'People also ask',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueGrey,
                  ),
                ),
              )
            ],
          )),
    );
  }

  _itemBuilderCircularIndicator(
      String imageAssets, String title, double percent) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(left: 20),
        height: 150,
        width: 120,
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 5),
            CircularPercentIndicator(
              radius: 40,
              animation: true,
              circularStrokeCap: CircularStrokeCap.round,
              center: Container(
                height: 70,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child: Image.asset(
                  imageAssets,
                ),
              ),
              lineWidth: 6,
              percent: percent,
              progressColor: Colors.green[400],
            ),
            Container(
              height: 30,
              width: 70,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 15, bottom: 15, right: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

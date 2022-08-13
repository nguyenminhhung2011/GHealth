import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/fasting_plan_controller.dart';
import 'package:gold_health/apps/pages/list_plan_screen/fasting_plan/count_down_timer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:timelines/timelines.dart';

class FastingCountdownScreen extends StatefulWidget {
  const FastingCountdownScreen({Key? key}) : super(key: key);

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
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < 4; i++)
                  _itemBuilderReel(i <= 1 ? false : true)
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        const CountDownTimer(duration: Duration(seconds: 10)),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {},
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
                  '14-10',
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
        SizedBox(height: 100, child: fastingPlanController.timeline()),
        const SizedBox(height: 20),
        Container(
          height: Get.mediaQuery.size.height * 0.18,
          width: Get.mediaQuery.size.width * 0.8,
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
          width: Get.mediaQuery.size.width * 0.8,
          margin: const EdgeInsets.all(10),
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
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
                side: const BorderSide(width: 2, color: Colors.deepOrange)),
            alignment: Alignment.center,
            elevation: 0,
            fixedSize: Size(
              Get.mediaQuery.size.width * 0.8,
              70,
            ),
          ),
          child: const Text(
            'End fasting',
            style: TextStyle(
              color: Colors.deepOrange,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  _itemBuilderReel(bool isReel) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        height: 150,
        width: 120,
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(20),
        ),
        child: isReel
            ? Column(
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
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 5),
                  CircularPercentIndicator(
                    radius: 40,
                    animation: true,
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Container(
                      height: 74,
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: Image.asset(
                        'assets/images/blood.png',
                      ),
                    ),
                    lineWidth: 4,
                    percent: 0.3,
                    progressColor: Colors.green[400],
                  ),
                  Container(
                    height: 30,
                    width: 70,
                    alignment: Alignment.center,
                    margin:
                        const EdgeInsets.only(top: 15, bottom: 15, right: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Text(
                      '0h - 2h',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/global_widgets/screen_template.dart';
import 'package:gold_health/apps/pages/list_plan_screen/fasting_plan/fasting_countdown_screen.dart';
import 'package:gold_health/apps/pages/list_plan_screen/fasting_plan/get_ready_screen.dart';

import '../../../controls/dailyPlanController/fasting_plan_controller.dart';
import '../../../template/misc/colors.dart';

class FastingPlanScreen extends StatefulWidget {
  const FastingPlanScreen({Key? key}) : super(key: key);

  @override
  State<FastingPlanScreen> createState() => _FastingPlanScreenState();
}

class _FastingPlanScreenState extends State<FastingPlanScreen> {
  final controller = Get.put(FastingPlanController());

  late final choicesWidget = controller.choices
      .map(
        (e) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Obx(
            () => !controller.isCountDown.value
                ? Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 5,
                      color: Colors.white,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          controller.fastingMode = e;
                          Get.to(() => GetReadyScreen(
                              fastingMode: controller.fastingMode));
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
                                          ? (e['opacityStarColor'] as Color)
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
                                            color: (e['starColor'] as Color)
                                                .withOpacity(0.5),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            info,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
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
                  )
                : const SizedBox(),
          ),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;

    List<String> tabs = [
      'Nutrition',
      'Workout',
      'Foot step',
      'Water',
      'Fasting',
      'Sleep'
    ];
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: ScreenTemplate(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () async {
                      int? newIndex;
                      await _showDialogMethod(
                        context: context,
                        tabs: tabs,
                        onSelectedTabs: (value) {
                          newIndex = value;
                        },
                        done: () {
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
                          'Fasting',
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
            ),
            ...choicesWidget,
            Obx(() => controller.isCountDown.value
                ? FastingCountdownScreen(
                    timeline:
                        CustomTimeLine(fastingMode: controller.fastingMode),
                  )
                : const SizedBox()),
          ],
        ),
      ),
    );
  }

  _showDialogMethod({
    required BuildContext context,
    required List<String> tabs,
    required Function(int)? onSelectedTabs,
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
                    onSelectedItemChanged: onSelectedTabs,
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

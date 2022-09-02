import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/daily_sleep_controller.dart';

import '../../../data/models/sleep.dart';
import '../../../global_widgets/dialog/yes_no_dialog.dart';
import '../../../template/misc/colors.dart';

class DialogUpdateDelete extends StatefulWidget {
  const DialogUpdateDelete({
    Key? key,
    required this.element,
  }) : super(key: key);
  final Sleep element;

  @override
  State<DialogUpdateDelete> createState() => _DialogUpdateDeleteState();
}

class _DialogUpdateDeleteState extends State<DialogUpdateDelete> {
  Rx<DateTime> choseTime = DateTime.now().obs;
  Rx<Duration> choseDuration = const Duration(hours: 8).obs;

  Map<String, dynamic> listVariable = {
    'Sun': false.obs,
    'Mon': false.obs,
    'Tue': false.obs,
    'Wed': false.obs,
    'Thu': false.obs,
    'Fri': false.obs,
    'Sat': false.obs,
  };
  List intToWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    choseTime.value = widget.element.bedTime;
    choseDuration.value = Duration(
        hours: widget.element.alarm.difference(widget.element.bedTime).inHours);
    for (var item in widget.element.listDate) {
      listVariable[intToWeek[item - 1]] = true.obs;
    }
  }

  Widget build(BuildContext context) {
    return GetBuilder<DailySleepController>(
      init: DailySleepController(),
      builder: (controller) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: double.infinity,
            height: 660,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Edit Time Sleep Schedule',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primaryColor1.withOpacity(0.2),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/Icon-Bed_alarm.svg'),
                          const Text(
                            'BedTime',
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 130,
                        child: CupertinoDatePicker(
                          onDateTimeChanged: (value) {
                            choseTime.value = value;
                          },
                          mode: CupertinoDatePickerMode.time,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primaryColor1.withOpacity(0.2),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/Icon-Time.svg'),
                          const Text(
                            'Hours of sleep',
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 130,
                        child: CupertinoTimerPicker(
                          mode: CupertinoTimerPickerMode.hm,
                          onTimerDurationChanged: (value) {
                            choseDuration.value = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primaryColor1.withOpacity(0.2),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/Icon-Repeat.svg'),
                          const Text(
                            'Repeat',
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          )
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 80,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                'Sun',
                                'Mon',
                                'Tue',
                                'Wed',
                                'Thu',
                                'Fri',
                                'Sat',
                              ]
                                  .map((e) => InkWell(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        onTap: () {
                                          (listVariable[e] as RxBool).value =
                                              !(listVariable[e] as RxBool)
                                                  .value;
                                        },
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Obx(
                                              () => AnimatedContainer(
                                                curve: Curves
                                                    .fastLinearToSlowEaseIn,
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                alignment: Alignment.center,
                                                height:
                                                    (listVariable[e] as RxBool)
                                                            .value
                                                        ? 45
                                                        : 0,
                                                width:
                                                    (listVariable[e] as RxBool)
                                                            .value
                                                        ? 45
                                                        : 0,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: AppColors
                                                          .primaryColor1,
                                                      width: 2),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              height: 45,
                                              width: 45,
                                              alignment: Alignment.center,
                                              child: Text(
                                                e,
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList()),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.primaryColor1,
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      final r = await Get.dialog(YesNoDialog(
                          press: () {
                            List<int> dateSelect = [];
                            listVariable.forEach((key, value) {
                              if ((value as RxBool).value) {
                                dateSelect.add(controller.weekDayTonInt[key]);
                              }
                            });
                            controller.updateDataCollection({
                              'id': widget.element.id,
                              'bedTime': choseTime.value,
                              'alarm':
                                  (choseTime.value).add((choseDuration.value)),
                              'isTurnOn': widget.element.isTurnOn,
                              'isTurnOn1': widget.element.isTurnOn1,
                              'listDate': dateSelect.isNotEmpty
                                  ? dateSelect
                                  : [1, 2, 3, 4, 5, 6, 7],
                            });
                            // initAll();
                            Get.back(result: true);
                          },
                          question: 'Do you want Update this schedule ?',
                          title1:
                              'This sleep time will be updated from your schedule',
                          title2: ''));
                      print(r);
                      if (r == true) {
                        Get.back();
                      }
                      // Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.mainColor,
                    border:
                        Border.all(width: 2, color: AppColors.primaryColor1),
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      final r = await Get.dialog(YesNoDialog(
                          press: () {
                            controller.deleteDataCollection(widget.element.id);
                            Get.back(result: true);
                          },
                          question: 'Do you want Delete this schedule ?',
                          title1:
                              'This sleep time will be removed from your schedule',
                          title2: ''));
                      print(r);
                      if (r == true) {
                        Get.back();
                      }
                      // Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: const Text(
                      'Delete Time',
                      style: TextStyle(
                        color: AppColors.primaryColor1,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/global_widgets/screen_template.dart';
import 'package:intl/intl.dart';

import '../../template/misc/colors.dart';
import '../dashboard/widgets/button_gradient.dart';

class AddAlarmScreen extends StatefulWidget {
  AddAlarmScreen({Key? key, required this.listSchedule}) : super(key: key);
  List<Map<String, dynamic>> listSchedule;
  @override
  State<AddAlarmScreen> createState() => _AddAlarmScreenState();
}

class _AddAlarmScreenState extends State<AddAlarmScreen> {
  var isExpandBedTime = false.obs;
  var isExpandHoursOfSleep = false.obs;
  var isExpandRepeat = false.obs;
  var isVibrate = true.obs;

  var choseTime = DateTime.now().obs;
  DateTime tempTime = DateTime.now();

  var choseDuration = const Duration(hours: 8).obs;
  Duration tempDuration = const Duration();

  Map<String, dynamic> listVariable = {
    'Sun': false.obs,
    'Mon': false.obs,
    'Tue': false.obs,
    'Wed': false.obs,
    'Thu': false.obs,
    'Fri': false.obs,
    'Sat': false.obs,
  };

  Widget _itemBuilderRepeat(String day) {
    return InkWell(
      onTap: () {
        (listVariable[day] as RxBool).value =
            !(listVariable[day] as RxBool).value;
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Obx(
            () => AnimatedContainer(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(milliseconds: 500),
              alignment: Alignment.center,
              height: (listVariable[day] as RxBool).value ? 30 : 0,
              width: (listVariable[day] as RxBool).value ? 43 : 0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryColor2,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            height: 30,
            width: 43,
            alignment: Alignment.center,
            child: Text(
              day,
              style: const TextStyle(fontSize: 13.5, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: ScreenTemplate(
        child: SafeArea(
          child: SizedBox(
            height: heightDevice,
            width: widthDevice,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 20,
                          ),
                        ),
                        const Text(
                          'Add Alarm',
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_horiz),
                        )
                      ],
                    ),
                    Obx(
                      () => AnimatedContainer(
                        alignment: Alignment.center,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.primaryColor1.withOpacity(0.2),
                        ),
                        height: isExpandBedTime.value
                            ? heightDevice * 0.25
                            : heightDevice * 0.1,
                        child: Column(
                          mainAxisAlignment: isExpandBedTime.value
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.center,
                          children: [
                            ListTile(
                              leading: SvgPicture.asset(
                                  'assets/icons/Icon-Bed_alarm.svg'),
                              title: const Text(
                                'BedTime',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                              trailing: Container(
                                  alignment: Alignment.centerRight,
                                  width: 100,
                                  child: InkWell(
                                    onTap: () {
                                      isExpandBedTime.value =
                                          !isExpandBedTime.value;
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Obx(() => Text(
                                              DateFormat()
                                                  .add_jm()
                                                  .format(choseTime.value),
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey[400],
                                              ),
                                            )),
                                        (isExpandBedTime.value)
                                            ? const Icon(
                                                Icons
                                                    .keyboard_arrow_down_outlined,
                                                size: 20)
                                            : const Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 15),
                                      ],
                                    ),
                                  )),
                            ),
                            if (isExpandBedTime.value)
                              FutureBuilder(
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Expanded(
                                      child: CupertinoDatePicker(
                                        onDateTimeChanged: (value) {
                                          tempTime = value;
                                        },
                                        mode: CupertinoDatePickerMode.time,
                                      ),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                                future: Future.delayed(
                                    const Duration(milliseconds: 550)),
                              ),
                            if (isExpandBedTime.value)
                              const SizedBox(height: 10),
                            if (isExpandBedTime.value)
                              FutureBuilder(
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            choseTime.value = tempTime;
                                            isExpandBedTime.value =
                                                !isExpandBedTime.value;
                                          },
                                          child: Text(
                                            'Save',
                                            style: TextStyle(
                                              color: Colors.blue[400],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            isExpandBedTime.value =
                                                !isExpandBedTime.value;
                                          },
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: Colors.blue[400],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                                future: Future.delayed(
                                    const Duration(milliseconds: 550)),
                              )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Obx(
                      () => AnimatedContainer(
                        alignment: Alignment.center,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.primaryColor1.withOpacity(0.2),
                        ),
                        height: isExpandHoursOfSleep.value
                            ? heightDevice * 0.25
                            : heightDevice * 0.1,
                        child: Column(
                          mainAxisAlignment: isExpandHoursOfSleep.value
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.center,
                          children: [
                            ListTile(
                              leading: SvgPicture.asset(
                                  'assets/icons/Icon-Time.svg'),
                              title: const Text(
                                'Hours of sleep',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                              trailing: Container(
                                  alignment: Alignment.centerRight,
                                  width: 150,
                                  child: InkWell(
                                    onTap: () {
                                      isExpandHoursOfSleep.value =
                                          !isExpandHoursOfSleep.value;
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Obx(
                                          () => Text(
                                            '${choseDuration.value.inHours}hours ${choseDuration.value.inMinutes - choseDuration.value.inHours * 60}minutes',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey[400],
                                            ),
                                          ),
                                        ),
                                        (isExpandHoursOfSleep.value)
                                            ? const Icon(
                                                Icons
                                                    .keyboard_arrow_down_outlined,
                                                size: 20)
                                            : const Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 15),
                                      ],
                                    ),
                                  )),
                            ),
                            if (isExpandHoursOfSleep.value)
                              FutureBuilder(
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return SizedBox(
                                      height: 100,
                                      child: CupertinoTimerPicker(
                                        mode: CupertinoTimerPickerMode.hm,
                                        onTimerDurationChanged: (value) {
                                          tempDuration = value;
                                        },
                                      ),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                                future: Future.delayed(
                                    const Duration(milliseconds: 550)),
                              ),
                            if (isExpandHoursOfSleep.value)
                              const SizedBox(height: 10),
                            if (isExpandHoursOfSleep.value)
                              FutureBuilder(
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            choseDuration.value = tempDuration;
                                            isExpandHoursOfSleep.value =
                                                !isExpandHoursOfSleep.value;
                                          },
                                          child: Text(
                                            'Save',
                                            style: TextStyle(
                                              color: Colors.blue[400],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            isExpandHoursOfSleep.value =
                                                !isExpandHoursOfSleep.value;
                                          },
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: Colors.blue[400],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                                future: Future.delayed(
                                    const Duration(milliseconds: 550)),
                              )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Obx(
                      () => AnimatedContainer(
                        alignment: Alignment.center,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.primaryColor1.withOpacity(0.2),
                        ),
                        height: isExpandRepeat.value
                            ? heightDevice * 0.17
                            : heightDevice * 0.1,
                        child: Column(
                          mainAxisAlignment: isExpandRepeat.value
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.center,
                          children: [
                            ListTile(
                              leading: SvgPicture.asset(
                                  'assets/icons/Icon-Repeat.svg'),
                              title: const Text(
                                'Repeat',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                              trailing: Container(
                                  alignment: Alignment.centerRight,
                                  width: 200,
                                  child: InkWell(
                                    onTap: () {
                                      isExpandRepeat.value =
                                          !isExpandRepeat.value;
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Obx(
                                          () {
                                            String date = '';
                                            int numberChose = 0;
                                            (listVariable)
                                                .forEach((key, value) {
                                              if ((value as RxBool).value) {
                                                date += '$key, ';
                                                numberChose++;
                                              }
                                            });
                                            if (numberChose == 0) {
                                              date = 'Tomorrow';
                                            } else if (numberChose == 7) {
                                              date = 'Every day';
                                            } else {
                                              date = 'Every $date';
                                            }
                                            return Expanded(
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  date,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey[400],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        (isExpandRepeat.value)
                                            ? const Icon(
                                                Icons
                                                    .keyboard_arrow_down_outlined,
                                                size: 20)
                                            : const Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 15),
                                      ],
                                    ),
                                  )),
                            ),
                            if (isExpandRepeat.value)
                              FutureBuilder(
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            'Sun',
                                            'Mon',
                                            'Tue',
                                            'Wed',
                                            'Thu',
                                            'Fri',
                                            'Sat',
                                          ]
                                              .map((element) =>
                                                  _itemBuilderRepeat(element))
                                              .toList()),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                                future: Future.delayed(
                                    const Duration(milliseconds: 550)),
                              ),
                            if (isExpandRepeat.value)
                              const SizedBox(height: 10),
                            if (isExpandRepeat.value)
                              FutureBuilder(
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Center(
                                      child: TextButton(
                                          onPressed: () {
                                            isExpandRepeat.value =
                                                !isExpandRepeat.value;
                                          },
                                          child: Text('Save',
                                              style: TextStyle(
                                                  color: Colors.blue[400]))),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                                future: Future.delayed(
                                    const Duration(milliseconds: 550)),
                              )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.primaryColor1.withOpacity(0.2),
                      ),
                      alignment: Alignment.center,
                      height: heightDevice * 0.1,
                      child: ListTile(
                        leading:
                            SvgPicture.asset('assets/icons/Icon-Vibrate.svg'),
                        title: const Text(
                          'Vibrate When Alarm Sound',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        trailing: Container(
                            alignment: Alignment.centerRight,
                            width: 150,
                            child: Obx(
                              () => CupertinoSwitch(
                                activeColor: Colors.blue[300],
                                value: isVibrate.value,
                                onChanged: (value) =>
                                    isVibrate.value = !isVibrate.value,
                              ),
                            )),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.only(bottom: 30),
                        child: ButtonGradient(
                          height: heightDevice * 0.06,
                          width: widthDevice * 0.9,
                          linearGradient: LinearGradient(colors: [
                            Colors.blue[200]!,
                            Colors.blue[300]!,
                            Colors.blue[400]!
                          ]),
                          onPressed: () {
                            //  {
                            //   'name': 'Bedtime',
                            //   'icon': 'assets/images/bed.png',
                            //   'time': DateTime(2022, 8, 5, 21),
                            //   'isTurnOn': true,
                            // },
                            widget.listSchedule.add(
                              {
                                'name': 'Bedtime',
                                'icon': 'assets/images/bed.png',
                                'time': choseTime.value,
                                'isTurnOn': true,
                              },
                            );
                            Navigator.of(context).pop();
                          },
                          title: const Text(
                            'Save',
                            style: TextStyle(
                                fontFamily: 'Sen',
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

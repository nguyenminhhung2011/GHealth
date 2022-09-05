import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/daily_sleep_controller.dart';
import 'package:gold_health/apps/global_widgets/screen_template.dart';
import 'package:progressive_time_picker/progressive_time_picker.dart';
import 'package:intl/intl.dart' as intl;

import '../../routes/route_name.dart';
import '../../template/misc/colors.dart';

class SelectSleepTime extends StatefulWidget {
  const SelectSleepTime({Key? key}) : super(key: key);

  @override
  _SelectSleepTimeState createState() => _SelectSleepTimeState();
}

class _SelectSleepTimeState extends State<SelectSleepTime> {
  final ClockTimeFormat _clockTimeFormat = ClockTimeFormat.TWENTYFOURHOURS;
  final controller = Get.find<DailySleepController>();

  final double _sleepGoal = 8.0;
  bool _isSleepGoal = false;
  RxBool isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    _isSleepGoal = (_sleepGoal >= 8.0) ? true : false;
    controller.intervalBedTime = formatIntervalTime(
        init: controller.inBedTime,
        end: controller.outBedTime,
        clockTimeFormat: _clockTimeFormat);
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                const SizedBox(height: 40),
                const Text(
                  'Sleep Time',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TimePicker(
                  initTime: controller.inBedTime,
                  endTime: controller.outBedTime,
                  height: 260.0,
                  width: 260.0,
                  onSelectionChange: _updateLabels,
                  onSelectionEnd: (a, b) => print(
                      'onSelectionEnd => init : ${a.h}:${a.m}, end : ${b.h}:${b.m}'),
                  primarySectors: _clockTimeFormat.value,
                  secondarySectors: _clockTimeFormat.value * 2,
                  decoration: TimePickerDecoration(
                    baseColor: Colors.white.withOpacity(0.2),
                    pickerBaseCirclePadding: 15.0,
                    sweepDecoration: TimePickerSweepDecoration(
                      pickerStrokeWidth: 30.0,
                      pickerColor:
                          _isSleepGoal ? AppColors.primaryColor : Colors.white,
                      showConnector: true,
                    ),
                    initHandlerDecoration: TimePickerHandlerDecoration(
                      color: const Color(0xFF141925),
                      shape: BoxShape.circle,
                      radius: 12.0,
                      icon: const Icon(
                        Icons.power_settings_new_outlined,
                        size: 20.0,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    endHandlerDecoration: TimePickerHandlerDecoration(
                      color: const Color(0xFF141925),
                      shape: BoxShape.circle,
                      radius: 12.0,
                      icon: const Icon(
                        Icons.notifications_active_outlined,
                        size: 20.0,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    primarySectorsDecoration: TimePickerSectorDecoration(
                      color: Colors.white,
                      width: 1.0,
                      size: 4.0,
                      radiusPadding: 25.0,
                    ),
                    secondarySectorsDecoration: TimePickerSectorDecoration(
                      color: AppColors.primaryColor,
                      width: 1.0,
                      size: 2.0,
                      radiusPadding: 25.0,
                    ),
                    clockNumberDecoration: TimePickerClockNumberDecoration(
                      defaultTextColor: Colors.white,
                      defaultFontSize: 12.0,
                      scaleFactor: 2.0,
                      showNumberIndicators: true,
                      clockTimeFormat: _clockTimeFormat,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(62.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${intl.NumberFormat('00').format(controller.intervalBedTime.h)}Hr ${intl.NumberFormat('00').format(controller.intervalBedTime.m)}Min',
                          style: TextStyle(
                              fontSize: 14.0,
                              color: _isSleepGoal
                                  ? AppColors.primaryColor
                                  : Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _isSleepGoal
                          ? "Above Sleep Goal 😄"
                          : 'below Sleep Goal 😴',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: _timeWidget(
                          'BedTime',
                          controller.inBedTime,
                          const Icon(
                            Icons.power_settings_new_outlined,
                            size: 25.0,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _timeWidget(
                          'WakeUp',
                          controller.outBedTime,
                          const Icon(
                            Icons.notifications_active_outlined,
                            size: 25.0,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    // padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.primaryColor,
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        isLoading.value = true;
                        String nextPage =
                            await controller.addNewSleepReportToFirebase();
                        isLoading.value = false;
                        if (nextPage == 'Success') {
                          Get.offNamed(RouteName.sleepCounting);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        alignment: Alignment.center,
                        fixedSize: const Size(double.infinity, 45),
                        elevation: 0,
                      ),
                      child: isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white))
                          : const Text(
                              'Set Alarm',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeWidget(String title, PickedTime time, Icon icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Text(
              '${intl.NumberFormat('00').format(time.h)}:${intl.NumberFormat('00').format(time.m)}',
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            icon,
          ],
        ),
      ),
    );
  }

  void _updateLabels(PickedTime init, PickedTime end) {
    controller.inBedTime = init;
    controller.outBedTime = end;
    controller.intervalBedTime = formatIntervalTime(
        init: controller.inBedTime,
        end: controller.outBedTime,
        clockTimeFormat: _clockTimeFormat);
    _isSleepGoal = validateSleepGoal(
      inTime: init,
      outTime: end,
      sleepGoal: _sleepGoal,
      clockTimeFormat: _clockTimeFormat,
    );
    setState(() {});
  }
}

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gold_health/services/alarm_notify.dart';

import '../controls/workout_controller/workout_plan_controller.dart';
import '../template/misc/colors.dart';

class ToggleButtonIos extends StatefulWidget {
  ToggleButtonIos({Key? key, required this.val, required this.scheduleId})
      : super(key: key);
  bool val;
  final String scheduleId;
  @override
  State<ToggleButtonIos> createState() => _ToggleButtonIosState();
}

class _ToggleButtonIosState extends State<ToggleButtonIos> {
  final _workoutController = Get.find<WorkoutPlanController>();
  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      activeColor: AppColors.primaryColor1,
      value: widget.val,
      onChanged: (bool value) async {
        widget.val = value;
        if (widget.val == false) {
          int? isolateId =
              WorkoutPlanController.sharedPreferences.getInt(widget.scheduleId);
          if (isolateId != null) {
            AlarmNotify.cancelAlarmNotification(isolateId);
            await WorkoutPlanController.sharedPreferences
                .remove(widget.scheduleId);
          }
        } else {
          int isolatedId = await AlarmNotify.alarmNotification(
              _workoutController.schedules.value[widget.scheduleId]!.time);
          await WorkoutPlanController.sharedPreferences
              .setInt(widget.scheduleId, isolatedId);
        }
        setState(() {});
      },
    );
  }
}

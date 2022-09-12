import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gold_health/constrains.dart';
import '../../services/notification.dart';
import '../controls/workout_controller/workout_plan_controller.dart';
import '../template/misc/colors.dart';

// ignore: must_be_immutable
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
          //Delete alarm
          final sharedPreferencesInstance = await sharedPreferences;
          int? id = sharedPreferencesInstance.getInt(widget.scheduleId);
          if (id != null) {
            cancelScheduleNotificationsWhere(id);
            sharedPreferencesInstance.remove(widget.scheduleId);
          }
        } else {
          //Create alarm notification
          int id = await createWorkoutNotificationAuto(
              NotificationCalendar.fromDate(
                  date: _workoutController
                      .schedules.value[widget.scheduleId]!.time));
          final sharedPreferencesInstance = await sharedPreferences;
          sharedPreferencesInstance.setInt(widget.scheduleId, id);
        }
        setState(() {});
      },
    );
  }
}

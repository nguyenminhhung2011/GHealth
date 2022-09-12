import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/workout_controller/workout_plan_controller.dart';
import 'package:gold_health/constrains.dart';

import '../../../global_widgets/toggle_button_ios.dart';
import '../../../template/misc/colors.dart';

class UpComingWorkoutContainer extends StatelessWidget {
  const UpComingWorkoutContainer({
    Key? key,
    required this.scheduleId,
    required this.val,
    required this.main,
    required this.time,
    required this.imagePath,
  }) : super(key: key);

  final String scheduleId;
  final bool val;
  final String main;
  final String time;
  final String imagePath;

  void _deleteScheduleWorkout() async {
    try {
      bool response = await Get.find<WorkoutPlanController>()
          .deleteScheduleWorkout(scheduleId);
      if (response == true) {
        final sharePreferencesInstance = await sharedPreferences;
        sharePreferencesInstance.remove(scheduleId);
      }
    } catch (e) {
      debugPrint('_deleteScheduleWorkout: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(2, 3),
            blurRadius: 20,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(-2, -3),
            blurRadius: 20,
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: AppColors.primaryColor1,
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  imagePath,
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                main,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
              Text(
                time,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              )
            ],
          ),
          const Spacer(),
          Column(
            children: [
              ToggleButtonIos(
                val: val,
                scheduleId: scheduleId,
              ),
              IconButton(
                onPressed: _deleteScheduleWorkout,
                icon: const Icon(
                  Icons.delete,
                  size: 33,
                  color: Colors.grey,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

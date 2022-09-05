import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gold_health/apps/data/models/workout_model.dart';
import 'package:intl/intl.dart';

import '../../../template/misc/colors.dart';

class WorkoutHistoryCard extends StatelessWidget {
  const WorkoutHistoryCard({
    Key? key,
    required this.history,
    required this.imagePath,
  }) : super(key: key);
  final String imagePath;
  final WorkoutHistory history;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.primaryColor1.withOpacity(0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 120,
              width: 120,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                imagePath,
                bundle: PlatformAssetBundle(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  history.workoutCategory,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Level: ${history.level}mins',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '12 Exercises | 40mins',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Calories Burned: ${history.caloriesBurn}mins',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  DateFormat.yMd().add_jm().format(history.time),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

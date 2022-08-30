import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../template/misc/colors.dart';

class MealNutritionCard extends StatelessWidget {
  const MealNutritionCard({
    Key? key,
    required this.widthDevice,
    required this.percent,
    required this.title,
    required this.imagePath,
    required this.data,
  }) : super(key: key);

  final double widthDevice;
  final double percent;
  final String title;
  final String imagePath;
  final String data;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            offset: const Offset(2, 3),
            blurRadius: 20,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            offset: const Offset(-2, -3),
            blurRadius: 20,
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const SizedBox(width: 4),
              Image.asset(
                imagePath,
                height: 20,
                width: 20,
              ),
              const Spacer(),
              Text(
                data,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          // ignore: sized_box_for_whitespace
          Container(
            width: widthDevice,
            height: 15,
            child: LinearPercentIndicator(
              lineHeight: 40,
              percent: percent > 1 ? 1 : percent,
              progressColor: (percent >= 0.5)
                  ? (percent > 1)
                      ? Colors.green.withOpacity(0.4)
                      : AppColors.primaryColor1
                  : AppColors.primaryColor2,
              backgroundColor: Colors.grey.withOpacity(0.2),
              animation: true,
              animationDuration: 1000,
              barRadius: const Radius.circular(20),
            ),
          )
        ],
      ),
    );
  }
}

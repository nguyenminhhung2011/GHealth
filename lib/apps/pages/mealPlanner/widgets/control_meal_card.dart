import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../template/misc/colors.dart';

class ControlMealCard extends StatelessWidget {
  const ControlMealCard({
    Key? key,
    required this.header,
    required this.percent,
  }) : super(key: key);
  final String header;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.primaryColor1.withOpacity(0.2),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '$header ',
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${percent * 100}%',
                style: TextStyle(
                  color: (percent > 0.5) ? Colors.green : Colors.red,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 120,
            height: 10,
            child: LinearPercentIndicator(
              lineHeight: 30,
              percent: percent,
              progressColor: (percent > 0.5)
                  ? Colors.green.withOpacity(0.5)
                  : Colors.red.withOpacity(0.5),
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

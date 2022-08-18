import 'package:flutter/material.dart';

import '../template/misc/colors.dart';

class BarChartItem extends StatelessWidget {
  final double heightOfBar;
  final double firstData;
  final double seconData;
  const BarChartItem(
      {Key? key,
      required this.heightOfBar,
      required this.firstData,
      required this.seconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Container(
            width: 30,
            height: heightOfBar,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.primaryColor.withOpacity(0.05),
            ),
          ),
          Column(
            children: [
              const Spacer(),
              Container(
                width: 30,
                height: seconData / firstData * heightOfBar,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: (seconData / firstData > 0.5)
                      ? AppColors.primaryColor2
                      : AppColors.primaryColor1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

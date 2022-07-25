import 'package:flutter/material.dart';
import 'package:gold_health/apps/global_widgets/GradientText.dart';

import '../template/misc/colors.dart';

class TargetCard extends StatelessWidget {
  final String imagePath;
  final String data;
  final String targetType;
  const TargetCard({
    Key? key,
    required this.imagePath,
    required this.data,
    required this.targetType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Expanded(
              child: Image.asset(
                imagePath,
                height: 50,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GradientText(
                    data,
                    gradient: AppColors.colorGradient,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
//                  const SizedBox(height: 10),
                  Text(
                    targetType,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

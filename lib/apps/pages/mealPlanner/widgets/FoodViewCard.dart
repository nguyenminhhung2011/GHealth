import 'package:flutter/material.dart';

import '../../../global_widgets/ButtonText.dart';
import '../../../template/misc/colors.dart';

class FoodViewCard extends StatelessWidget {
  const FoodViewCard({
    Key? key,
    required this.nameFoods,
    required this.level,
    required this.time,
    required this.kCal,
    required this.press,
    required this.checkCOlor,
    required this.imagePath,
  }) : super(key: key);
  final String nameFoods;
  final String imagePath;
  final String level;
  final int time;
  final int kCal;
  final Function() press;
  final int checkCOlor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: (checkCOlor == 0)
            ? AppColors.primaryColor1.withOpacity(0.2)
            : AppColors.primaryColor2.withOpacity(0.2),
      ),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 130,
            height: 130,
          ),
          Text(
            nameFoods,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          Text(
            '${level} | ${time}mins | ${kCal}kCal',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          ButtonText(
            press: press,
            title: 'View',
            color: (checkCOlor == 0)
                ? AppColors.primaryColor1
                : AppColors.primaryColor2,
          )
        ],
      ),
    );
  }
}

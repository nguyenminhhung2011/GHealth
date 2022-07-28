import 'package:flutter/material.dart';

import '../../../global_widgets/GradientText.dart';
import '../../../template/misc/colors.dart';

class CategoriesWorkoutCard extends StatelessWidget {
  const CategoriesWorkoutCard({
    Key? key,
    required this.cate_name,
    required this.exer,
    required this.time,
    required this.imagePath,
    required this.press,
  }) : super(key: key);

  final String cate_name;
  final int exer;
  final int time;
  final String imagePath;
  final Function() press;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.primaryColor1.withOpacity(0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cate_name,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${exer} Exercises | ${time}mins',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: press,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: GradientText(
                      'View more',
                      gradient: AppColors.colorGradient,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 120,
              width: 120,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor1.withOpacity(0.2)),
              child: Image.asset(
                imagePath,
              ),
            ),
          )
        ],
      ),
    );
  }
}

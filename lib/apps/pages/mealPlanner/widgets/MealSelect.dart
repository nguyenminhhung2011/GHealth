import 'package:flutter/material.dart';

import '../../../global_widgets/ButtonText.dart';
import '../mealPlannerScreen.dart';

class MealSelect extends StatelessWidget {
  const MealSelect({
    Key? key,
    required this.collect,
    required this.imagePath,
    required this.noFoods,
    required this.press,
    required this.color,
    required this.color_btn,
  }) : super(key: key);
  final String collect;
  final String imagePath;
  final int noFoods;
  final Function() press;
  final Color color;
  final Color color_btn;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(100),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
        ),
        Positioned(
          top: -15,
          left: 80,
          child: Image.asset(
            height: 120,
            width: 120,
            imagePath,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 200,
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Spacer(),
                Text(
                  collect,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${noFoods} + foods',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                ButtonText(
                  press: press,
                  title: 'Select',
                  color: color_btn,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

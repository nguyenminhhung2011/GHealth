import 'package:flutter/material.dart';

import '../../../global_widgets/button_custom/button_text.dart';

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
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(100),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
          ),
          Positioned(
            top: -8,
            left: 80,
            child: Image.asset(
              height: 100,
              width: 100,
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
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '$noFoods + foods',
                    style: const TextStyle(
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
      ),
    );
  }
}

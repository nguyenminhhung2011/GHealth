import 'package:flutter/material.dart';

import '../template/misc/colors.dart';

class ButtonDesign extends StatelessWidget {
  final String title;
  final Function() press;
  const ButtonDesign({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(2, 3),
              blurRadius: 2,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(-2, -3),
              blurRadius: 2,
            )
          ],
        ),
        child: const Text(
          'Next',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

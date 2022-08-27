import 'package:flutter/material.dart';

import '../../template/misc/colors.dart';

class ButtonIconGradientColor extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() press;
  const ButtonIconGradientColor(
      {Key? key, required this.title, required this.icon, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: press,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          // gradient: AppColors.colorGradient,
          color: AppColors.primaryColor1,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 5),
            Icon(icon, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

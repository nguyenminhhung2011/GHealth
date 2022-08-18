import 'package:flutter/material.dart';

import '../../../template/misc/colors.dart';

class CategoryMealCard extends StatelessWidget {
  const CategoryMealCard({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.press,
  }) : super(key: key);
  final String imagePath;
  final String name;
  final Function() press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: press,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          margin: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.primaryColor1.withOpacity(0.4)),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.5),
                ),
                child: Image.asset(
                  imagePath,
                  height: 40,
                  width: 40,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

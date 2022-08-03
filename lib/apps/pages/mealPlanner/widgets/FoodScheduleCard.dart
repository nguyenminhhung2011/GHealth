import 'package:flutter/material.dart';

class FoodScheduleCard extends StatelessWidget {
  const FoodScheduleCard({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.time,
    required this.press,
    required this.color,
  }) : super(key: key);
  final String imagePath;
  final String name;
  final String time;
  final Function() press;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: color),
          child: Image.asset(
            height: 60,
            width: 60,
            imagePath,
          ),
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              time,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const Spacer(),
        InkWell(
          borderRadius: BorderRadius.circular(13),
          onTap: press,
          child: Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 17,
            ),
          ),
        ),
      ],
    );
  }
}

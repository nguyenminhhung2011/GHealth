import 'package:flutter/material.dart';

import '../../../template/misc/colors.dart';

class PopularFoodCard extends StatelessWidget {
  const PopularFoodCard({
    Key? key,
    required double widthDevice,
    required this.title,
    required this.time,
    required this.imagePath,
    required this.press,
    required this.kCal,
  })  : _widthDevice = widthDevice,
        super(key: key);

  final double _widthDevice;
  final String title;
  final int time;
  final int kCal;
  final String imagePath;
  final Function() press;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _widthDevice,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      margin: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            offset: const Offset(2, 3),
            blurRadius: 20,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            offset: const Offset(-2, -3),
            blurRadius: 20,
          )
        ],
      ),
      child: Row(
        children: [
          Image.network(imagePath, width: 65, height: 65),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${time < 21 ? 'Easy' : time < 40 ? 'Medium' : 'Hard'} | ${time}mins | ${kCal}kCal',
                style: const TextStyle(
                  color: Colors.grey,
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
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: AppColors.primaryColor1),
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primaryColor1,
                size: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

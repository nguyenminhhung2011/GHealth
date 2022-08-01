import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../template/misc/colors.dart';

class TodayMealCard extends StatelessWidget {
  const TodayMealCard({
    Key? key,
    required double widthDevice,
    required this.title,
    required this.time,
    required this.imagePath,
    required this.press,
  })  : _widthDevice = widthDevice,
        super(key: key);

  final double _widthDevice;
  final String title;
  final String time;
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
            offset: Offset(-2, -3),
            blurRadius: 20,
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  imagePath,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                time,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Spacer(),
          InkWell(
            borderRadius: BorderRadius.circular(13),
            onTap: press,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: AppColors.primaryColor1.withOpacity(0.2),
              ),
              child: SvgPicture.asset(
                'assets/icons/Notification.svg',
                color: AppColors.primaryColor1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

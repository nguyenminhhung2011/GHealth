import 'package:flutter/material.dart';

import '../template/misc/colors.dart';

class ActiCard extends StatelessWidget {
  final String title;
  final String mainTitle;
  final String imagePath;
  final Function() press;
  const ActiCard({
    Key? key,
    required this.widthDevice,
    required this.title,
    required this.mainTitle,
    required this.imagePath,
    required this.press,
  }) : super(key: key);

  final double widthDevice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: widthDevice,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.mainColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(2, 3),
              blurRadius: 20,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(-2, -3),
              blurRadius: 20,
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.5),
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    imagePath,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mainTitle,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Spacer(),
            InkWell(
              onTap: press,
              child: Icon(Icons.more_vert, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}

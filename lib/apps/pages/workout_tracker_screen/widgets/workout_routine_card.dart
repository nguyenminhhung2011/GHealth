import 'package:flutter/material.dart';

class WorkoutRoutineCard extends StatelessWidget {
  const WorkoutRoutineCard({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.getToPage,
    // required this.imagePath,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final Function() getToPage;
  // final String imagePath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: getToPage,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(2, 3),
              blurRadius: 20,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(-2, -3),
              blurRadius: 20,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Container(
            //   height: 60,
            //   width: 60,
            //   decoration: BoxDecoration(
            //     color: AppColors.primaryColor1,
            //     shape: BoxShape.circle,
            //     image: DecorationImage(
            //       fit: BoxFit.cover,
            //       image: AssetImage(
            //         imagePath,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subTitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: Colors.grey),
              ),
              child: const Icon(Icons.arrow_forward_ios,
                  color: Colors.grey, size: 17),
            ),
          ],
        ),
      ),
    );
  }
}

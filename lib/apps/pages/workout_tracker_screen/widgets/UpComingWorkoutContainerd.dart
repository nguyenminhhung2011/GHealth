import 'package:flutter/material.dart';

import '../../../global_widgets/ToggleButtonIos.dart';
import '../../../template/misc/colors.dart';

class UpComingWorkoutContainer extends StatelessWidget {
  const UpComingWorkoutContainer({
    Key? key,
    required this.val,
    required this.main,
    required this.time,
    required this.imagePath,
  }) : super(key: key);

  final bool val;
  final String main;
  final String time;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              color: AppColors.primaryColor1,
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  imagePath,
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                main,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              )
            ],
          ),
          Spacer(),
          ToggleButtonIos(val: val)
        ],
      ),
    );
  }
}

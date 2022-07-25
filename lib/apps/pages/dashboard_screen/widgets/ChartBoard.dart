import 'package:flutter/material.dart';

import '../../../data/fakeData.dart';
import '../../../template/misc/colors.dart';
import '../activity_trackerScreen.dart';

class ChartBoard extends StatelessWidget {
  const ChartBoard({
    Key? key,
    required this.widthDevice,
    required this.heightDevice,
    required this.week,
    required this.color,
    required this.title,
    required this.data,
  }) : super(key: key);

  final double widthDevice;
  final double heightDevice;
  final String week;
  final Color color;
  final String title;
  final String data;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthDevice,
      height: heightDevice / 3,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: color,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            week,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              Text(
                data,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              child: ChartCalories(
                heightOfBar: heightDevice / 3 - 80,
              ),
            ),
          ),
          Container(
              child: Row(
            children: FakeData.calories
                .map(
                  (e) => Expanded(
                    child: Text(
                      e['day'],
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                )
                .toList(),
          ))
        ],
      ),
    );
  }
}

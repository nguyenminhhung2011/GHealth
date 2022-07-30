import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../template/misc/colors.dart';

class FakeData {
  static List<Map<String, dynamic>> calories = [
    {
      'day': 'Sun',
      '1': 50.0,
      '2': 100.0,
    },
    {
      'day': 'Mon',
      '1': 60.0,
      '2': 100.0,
    },
    {
      'day': 'Tue',
      '1': 30.0,
      '2': 100.0,
    },
    {
      'day': 'Wed',
      '1': 40.0,
      '2': 100.0,
    },
    {
      'day': 'Thu',
      '1': 70.0,
      '2': 100.0,
    },
    {
      'day': 'Fri',
      '1': 20.0,
      '2': 100.0,
    },
    {
      'day': 'Sat',
      '1': 40.0,
      '2': 100.0,
    },
  ];
  static List<Data> data = [
    Data(
        name: 'now',
        percents: (30.1 / 80.1 * 100).round().toDouble(),
        color: AppColors.primaryColor2,
        imagePath: 'assets/images/fitness.png'),
    Data(
      name: '',
      percents: (50 / 80.1 * 100).round().toDouble(),
      color: AppColors.primaryColor1,
      imagePath: 'assets/images/medal.png',
    )
  ];

  static List<Map<String, dynamic>> list_set = [
    {
      "time": 35,
      "name": "Warm Up",
      "image":
          "https://barbend.com/wp-content/uploads/2022/05/shutterstock_583754929-1.jpg",
    },
    {
      "time": 25,
      "name": "Jumping Jack",
      "image":
          "https://barbend.com/wp-content/uploads/2022/05/shutterstock_583754929-1.jpg",
    },
    {
      "time": 15,
      "name": "Skipping",
      "image":
          "https://barbend.com/wp-content/uploads/2022/05/shutterstock_583754929-1.jpg",
    },
    {
      "time": 65,
      "name": "Squats",
      "image":
          "https://barbend.com/wp-content/uploads/2022/05/shutterstock_583754929-1.jpg",
    },
    {
      "time": 45,
      "name": "Arm Raises",
      "image":
          "https://barbend.com/wp-content/uploads/2022/05/shutterstock_583754929-1.jpg",
    },
    {
      "time": 65,
      "name": "Rest and Drink",
      "image":
          "https://barbend.com/wp-content/uploads/2022/05/shutterstock_583754929-1.jpg",
    },
  ];
}

class Data {
  final String name;
  final double percents;
  final Color color;
  final String imagePath;
  Data(
      {required this.imagePath,
      required this.name,
      required this.percents,
      required this.color});
}

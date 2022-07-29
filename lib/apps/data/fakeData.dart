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
          "https://dungcutheduc.vn/images/contents/bai-tap-jumping-jacks.jpg",
    },
    {
      "time": 15,
      "name": "Skipping",
      "image":
          "https://www.stylist.co.uk/images/app/uploads/2020/04/09112917/best-skipping-exercises-crop-1586428216-1120x1120.jpg?w=1200&h=1&fit=max&auto=format%2Ccompress",
    },
    {
      "time": 65,
      "name": "Squats",
      "image":
          "https://www.mensjournal.com/wp-content/uploads/mf/_main2_gobletswuat.jpg?w=900&quality=86&strip=all",
    },
    {
      "time": 45,
      "name": "Arm Raises",
      "image":
          "https://www.verywellfit.com/thmb/Ov3wmR7526ApOULGAV0Dy1qFLBg=/3000x2000/filters:fill(FFDB5D,1)/Frontraise-89445714d65d4c99a449e20aaa5bbadb.jpg",
    },
    {
      "time": 65,
      "name": "Rest and Drink",
      "image":
          "https://media.istockphoto.com/photos/female-athlete-taking-rest-and-drinking-woter-after-exercising-at-gym-picture-id1247629617?k=20&m=1247629617&s=170667a&w=0&h=mO9QoE2GvjtiHXHa3miHf9QV-TK_7z4qGpdH6XOT52M=",
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

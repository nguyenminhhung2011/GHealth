import 'package:flutter/material.dart';

class DataStepCard extends StatelessWidget {
  const DataStepCard({
    Key? key,
    required this.data,
    required this.title,
    required this.imagePath,
  }) : super(key: key);

  final double data;
  final String title;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(imagePath, height: 50, width: 50),
        Text(
          data.toStringAsFixed(2),
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
        ),
        Text(
          title,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
        )
      ],
    );
  }
}

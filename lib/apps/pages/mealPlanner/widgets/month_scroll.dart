// ignore: file_names
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MonthScroll extends StatelessWidget {
  String month;
  MonthScroll({Key? key, required this.month}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      // ignore: avoid_unnecessary_containers
      child: Container(
        child: Center(
          child: Text(
            month,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

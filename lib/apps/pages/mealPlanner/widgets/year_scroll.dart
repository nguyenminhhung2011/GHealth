import 'package:flutter/material.dart';

// ignore: must_be_immutable
class YearScroll extends StatelessWidget {
  int year;
  YearScroll({Key? key, required this.year}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      // ignore: avoid_unnecessary_containers
      child: Container(
        child: Center(
          child: Text(
            year.toString(),
            style: const TextStyle(
              fontSize: 40,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

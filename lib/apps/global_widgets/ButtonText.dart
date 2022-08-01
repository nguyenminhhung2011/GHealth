import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {
  const ButtonText({
    Key? key,
    required this.press,
    required this.title,
    required this.color,
  }) : super(key: key);
  final Function() press;
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: ElevatedButton(
        onPressed: press,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            primary: Colors.transparent,
            shadowColor: Colors.transparent),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

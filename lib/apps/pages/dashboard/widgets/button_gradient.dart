import 'package:flutter/material.dart';

class ButtonGradient extends StatelessWidget {
  final double height;
  final double width;
  final LinearGradient linearGradient;
  final void Function() onPressed;
  final Text title;

  const ButtonGradient(
      {Key? key,
      required this.height,
      required this.width,
      required this.linearGradient,
      required this.onPressed,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: linearGradient,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            primary: Colors.transparent,
            shadowColor: Colors.transparent),
        child: title,
      ),
    );
  }
}

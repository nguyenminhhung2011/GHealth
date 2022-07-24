import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../template/misc/colors.dart';

class BoxData extends StatelessWidget {
  final String text;
  final widthDevice;
  final heightDevice;
  const BoxData(
      {Key? key, this.widthDevice, this.heightDevice, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: widthDevice * 0.42,
      height: heightDevice * 0.06,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primaryColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Sen',
          fontSize: 25,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../template/misc/colors.dart';
import 'badge.dart';

class LoadHeightWeight extends StatelessWidget {
  const LoadHeightWeight({
    Key? key,
    required double widthDevice,
    required this.imgePath,
    required this.fData,
    required this.sData,
    required this.color,
    required this.press,
  })  : _widthDevice = widthDevice,
        super(key: key);

  final double _widthDevice;
  final String imgePath;
  final double fData;
  final double sData;
  final Color color;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Container(
              width: _widthDevice * 0.55,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primaryColor1.withOpacity(0.2),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: _widthDevice * 0.55 * (fData / sData) - 20,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                color: color,
              ),
            ),
            InkWell(
              onTap: press,
              child: Badge(
                imgePath,
                size: 25,
                borderColor: color,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

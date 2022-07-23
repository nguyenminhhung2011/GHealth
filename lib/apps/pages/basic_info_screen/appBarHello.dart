import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../template/misc/colors.dart';

class AppBarHello extends StatelessWidget {
  final double widthDevice;
  const AppBarHello({Key? key, required this.widthDevice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Hero(
          child: Image.asset(
            'assets/images/intro.png',
            height: widthDevice / 10,
            width: widthDevice / 10,
          ),
          tag: 'Splash image',
        ),
        const SizedBox(width: 5),
        Text.rich(
          TextSpan(
            style:
                Theme.of(context).textTheme.headline4!.copyWith(fontSize: 15),
            children: [
              TextSpan(
                text: 'Hello, I am ',
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: 'GHealth',
                style: TextStyle(
                  color: AppColors.primaryColor,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

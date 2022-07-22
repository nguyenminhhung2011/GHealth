import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../template/misc/colors.dart';

class btnIcon extends StatelessWidget {
  final Color color;
  final Function() press;
  final Widget icon;
  final Text title;
  const btnIcon(
      {Key? key,
      required this.color,
      required this.press,
      required this.icon,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(2, 3),
              blurRadius: 2,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(-2, -3),
              blurRadius: 2,
            )
          ],
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 10),
            title,
          ],
        ),
      ),
    );
  }
}

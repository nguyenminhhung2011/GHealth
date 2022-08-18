import 'package:flutter/material.dart';

class RowText_Seemore extends StatelessWidget {
  const RowText_Seemore({
    Key? key,
    required this.press,
    required this.title,
  }) : super(key: key);

  final Function() press;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline4!.copyWith(
                fontSize: 17,
              ),
        ),
        const Spacer(),
        InkWell(
          onTap: press,
          child: const Text(
            'See more',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

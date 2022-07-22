import 'package:flutter/material.dart';

import '../../../template/misc/colors.dart';

class SelectDurationButton extends StatelessWidget {
  final bool isSelected;
  final Function() press;
  final String times;
  final String cap;
  const SelectDurationButton({
    Key? key,
    required this.isSelected,
    required this.press,
    required this.times,
    required this.cap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: (!isSelected)
          ? Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1.2,
                  color: Colors.grey,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    times,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: 12,
                        ),
                  ),
                  Text(
                    cap,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontSize: 10),
                  ),
                ],
              ),
            )
          : Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: AppColors.colorOfButtonDuration),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    times,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: 12,
                        ),
                  ),
                  Text(
                    cap,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontSize: 10),
                  ),
                ],
              ),
            ),
    );
  }
}

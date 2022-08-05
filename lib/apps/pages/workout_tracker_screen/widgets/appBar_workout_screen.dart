import 'package:flutter/material.dart';

class AppBarWorkout extends StatelessWidget {
  const AppBarWorkout({
    Key? key,
    required this.press,
    required this.title,
  }) : super(key: key);

  final Function() press;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Row(
          children: [
            const SizedBox(width: 10),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black54,
                ),
              ),
            ),
            const Spacer(),
            Text(
              title,
              style:const  TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: press,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child:const  Icon(
                  Icons.more_horiz,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ],
    );
  }
}

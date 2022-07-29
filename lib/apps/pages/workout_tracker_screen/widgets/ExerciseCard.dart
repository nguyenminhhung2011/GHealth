import 'package:flutter/material.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({
    Key? key,
    required double widthDevice,
    required this.e,
  })  : _widthDevice = widthDevice,
        super(key: key);

  final double _widthDevice;
  final Map<String, dynamic> e;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            Container(
              height: _widthDevice / 6,
              width: _widthDevice / 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    e["image"],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e["name"],
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '00:${e["time"]}s',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Spacer(),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child:
                    Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

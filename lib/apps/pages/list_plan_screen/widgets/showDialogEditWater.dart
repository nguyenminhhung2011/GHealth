import 'package:flutter/material.dart';

import '../../../template/misc/colors.dart';
import '../selectAmountFood.dart';

class showDialogEditWater extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  showDialogEditWater({
    Key? key,
    required this.min,
    required this.max,
    required this.waterTarget,
    required this.waterConsumer,
  }) : super(key: key);
  final int min;
  final int max;
  late int waterTarget;
  late int waterConsumer;

  @override
  State<showDialogEditWater> createState() => _showDialogEditWaterState();
}

class _showDialogEditWaterState extends State<showDialogEditWater> {
  late int targetValue;
  late int consumeValue;
  int _value1 = 0;
  int _value2 = 0;
  @override
  void initState() {
    _value1 = widget.waterTarget;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 300,
        width: 120,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Water',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Align(
                alignment: Alignment.center,
                child:
                    RichTextCustom(size: 15, title: 'Target: ', data: _value1)),

            Slider(
              value: _value1.toDouble(),
              min: widget.waterTarget > 2000 ? (widget.waterTarget - 2000) : 0,
              max: widget.waterTarget.toDouble() + 2000.0,
              divisions: 100,
              activeColor: AppColors.primaryColor1,
              inactiveColor: Colors.grey.withOpacity(0.2),
              onChanged: (value) {
                setState(() {
                  _value1 = value.toInt();
                });
              },
            ),
            //const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child:
                  RichTextCustom(size: 15, title: 'Consume: ', data: _value2),
            ),
            Slider(
              value: _value2.toDouble(),
              min: 0,
              max: 2000,
              divisions: 100,
              activeColor: AppColors.primaryColor1,
              inactiveColor: Colors.grey.withOpacity(0.2),
              onChanged: (value) {
                setState(() {
                  _value2 = value.toInt();
                });
              },
            ),
            const Spacer(),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primaryColor1,
              ),
              child: ElevatedButton(
                onPressed: () {
                  widget.waterTarget = _value1;
                  widget.waterConsumer = _value2;
                  Navigator.of(context).pop({
                    'target': _value1,
                    'consume': _value2,
                  });
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent),
                child: const Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

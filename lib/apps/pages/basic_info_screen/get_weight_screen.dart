import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../global_widgets/buttonMain.dart';
import 'package:get/get.dart';
import '../../routes/routeName.dart';
import 'dart:math';

class GetWeightScreen extends StatefulWidget {
  const GetWeightScreen({Key? key}) : super(key: key);

  @override
  State<GetWeightScreen> createState() => _GetWeightScreenState();
}

class _GetWeightScreenState extends State<GetWeightScreen> {
  Container boxWeight(String text, var widthDevice, var heightDevice) {
    return Container(
      alignment: Alignment.center,
      width: widthDevice * 0.42,
      height: heightDevice * 0.06,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
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

  var list = [for (var i = 1; i <= 200; i++) i];
  int weight_kg = 1;
  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 30),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        height: heightDevice,
        width: widthDevice,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                  color: Colors.black,
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.only(right: 40),
                    alignment: Alignment.center,
                    child: Text(
                      'What is your weight?',
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'Provide your weight so that we can choose the most conform exercise for you. ',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: heightDevice * 0.25,
                    width: widthDevice * 0.4,
                    child: CupertinoPicker(
                      selectionOverlay: Container(
                        decoration: const BoxDecoration(
                          border: Border.symmetric(
                            horizontal: BorderSide(
                              width: 2,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      itemExtent: 77,
                      diameterRatio: 1.2,
                      onSelectedItemChanged: (int value) => setState(() {
                        weight_kg = value + 1;
                      }),
                      children: list
                          .map(
                            (e) => Text(
                              e.toString(),
                              style: const TextStyle(
                                fontFamily: 'Sen',
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      boxWeight('${weight_kg}kg', widthDevice, heightDevice),
                      boxWeight('${(weight_kg * 2.20462262).round()}lbs',
                          widthDevice, heightDevice),
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ButtonDesign(
                title: 'Next',
                press: () {
                  //Variable 'weight_kg' use for get age
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

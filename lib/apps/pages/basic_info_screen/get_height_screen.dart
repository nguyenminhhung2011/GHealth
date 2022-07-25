import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../global_widgets/boxData.dart';
import '../../global_widgets/buttonMain.dart';
import '../../routes/routeName.dart';
import '../../template/misc/colors.dart';
import '../dashboard_screen/activity_trackerScreen.dart';

class GetHeightScreen extends StatefulWidget {
  const GetHeightScreen({Key? key}) : super(key: key);

  @override
  State<GetHeightScreen> createState() => _GetHeightScreenState();
}

class _GetHeightScreenState extends State<GetHeightScreen> {
  var list = [for (var i = 100; i <= 300; i++) i];
  int height_cm = 100;
  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.mailColor,
      body: Container(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 30),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        height: heightDevice,
        width: widthDevice,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: heightDevice / 20),
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
                      'How tall are you?',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'Provide your height so that we can choose the most conform exercise for you. ',
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
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      itemExtent: 77,
                      diameterRatio: 1.2,
                      onSelectedItemChanged: (int value) => setState(
                        () {
                          height_cm = list[value];
                        },
                      ),
                      children: list
                          .map(
                            (e) => Row(
                              children: [
                                Text(
                                  e.toString(),
                                  style: const TextStyle(
                                    fontFamily: 'Sen',
                                    fontSize: 60,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'cm',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BoxData(
                          text: '${height_cm}cm',
                          widthDevice: widthDevice,
                          heightDevice: heightDevice),
                      BoxData(
                        text:
                            '${(height_cm * 0.032808399).toStringAsFixed(2)}ft',
                        widthDevice: widthDevice,
                        heightDevice: heightDevice,
                      ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActivityTrackerScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

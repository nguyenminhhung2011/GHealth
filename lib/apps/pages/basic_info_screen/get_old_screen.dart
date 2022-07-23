import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../global_widgets/buttonMain.dart';
import 'package:get/get.dart';
import '../../routes/routeName.dart';

class GetOldScreen extends StatefulWidget {
  const GetOldScreen({Key? key}) : super(key: key);

  @override
  State<GetOldScreen> createState() => _GetOldScreenState();
}

class _GetOldScreenState extends State<GetOldScreen> {
  var list = [for (var i = 10; i <= 100; i++) i];
  int age = 10;
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
                      'How old are you?',
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'Provide your age so that we can choose the most conform exercise for you. ',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Your age: $age',
                      style: const TextStyle(
                          fontSize: 30,
                          fontFamily: 'Sen',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
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
                        age = value + 10;
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
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ButtonDesign(
                title: 'Next',
                press: () {
                  //Variable 'age' use for get age
                  Get.toNamed(RouteName.selectHeight);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

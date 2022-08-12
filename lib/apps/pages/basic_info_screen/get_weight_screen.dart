import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import '../../global_widgets/boxData.dart';
import '../../global_widgets/buttonMain.dart';
import 'package:get/get.dart';
import '../../routes/routeName.dart';

import '../../template/misc/colors.dart';

class GetWeightScreen extends StatefulWidget {
  const GetWeightScreen({Key? key}) : super(key: key);

  @override
  State<GetWeightScreen> createState() => _GetWeightScreenState();
}

class _GetWeightScreenState extends State<GetWeightScreen> {
  var list = [for (var i = 1; i <= 200; i++) i];
  int weight_kg = 1;

  Widget _buildItemList(BuildContext context, int index) {
    return Container(
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 200,
            decoration: BoxDecoration(
              color:
                  (index + 1 == weight_kg) ? AppColors.mailColor : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 3, color: AppColors.primaryColor),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${list[index]}',
                    style: const TextStyle(
                      fontSize: 50.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Kg',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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
            SizedBox(height: heightDevice / 20),
            Row(
              children: [
                IconButton(
                  color: Colors.black,
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Get.back();
                  },
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.only(right: 40),
                    alignment: Alignment.center,
                    child: Text(
                      'What is your weight?',
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
              'Provide your weight so that we can choose the most conform exercise for you. ',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ScrollSnapList(
                      itemBuilder: _buildItemList,
                      itemSize: 150,
                      dynamicItemSize: true,
                      itemCount: list.length,
                      onItemFocus: (int) {
                        setState(() {
                          weight_kg = int + 1;
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BoxData(
                          text: '${weight_kg}kg',
                          widthDevice: widthDevice,
                          heightDevice: heightDevice),
                      BoxData(
                        text: '${(weight_kg * 2.20462262).round()}lbs',
                        widthDevice: widthDevice,
                        heightDevice: heightDevice,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: heightDevice / 15),
            Align(
              alignment: Alignment.bottomCenter,
              child: ButtonDesign(
                title: 'Next',
                press: () {
                  //Variable 'weight_kg' use for get age
                  Get.toNamed(RouteName.getHeight);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

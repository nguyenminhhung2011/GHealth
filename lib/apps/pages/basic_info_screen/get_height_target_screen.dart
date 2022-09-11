import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/basic_controller/get_height_target_controller.dart';

import '../../global_widgets/box_data.dart';
import '../../global_widgets/button_custom/button_main.dart';
import '../../template/misc/colors.dart';

class GetHeightTargetScreen extends StatelessWidget {
  GetHeightTargetScreen({Key? key}) : super(key: key);
  final _getHeightTargetC = Get.put(GetHeightTargetC());
  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;

    return Obx(
      () => Container(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 120),
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
                Flexible(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'What is your target height??',
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
                      onSelectedItemChanged: (int value) {
                        _getHeightTargetC.height.value =
                            _getHeightTargetC.list[value];
                      },
                      children: _getHeightTargetC.list
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
                                const Text(
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
                          text: '${_getHeightTargetC.height.value}cm',
                          widthDevice: widthDevice,
                          heightDevice: heightDevice),
                      BoxData(
                        text:
                            '${(_getHeightTargetC.height.value * 0.032808399).toStringAsFixed(2)}ft',
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
                press: () => _getHeightTargetC.nextBtnClick(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

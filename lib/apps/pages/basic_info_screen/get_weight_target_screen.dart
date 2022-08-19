import 'package:flutter/material.dart';
import 'package:gold_health/apps/controls/basic_controller/get_weight_target_controller.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import '../../global_widgets/box_data.dart';
import '../../global_widgets/button_custom/button_main.dart';
import 'package:get/get.dart';

import '../../template/misc/colors.dart';

class GetWeightTargetScreen extends StatelessWidget {
  GetWeightTargetScreen({Key? key}) : super(key: key);
  final _getWeightTargetC = Get.put(GetWeightTargetC());
  @override
  // ignore: override_on_non_overriding_member
  Widget _buildItemList(BuildContext context, int index) {
    return SizedBox(
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 200,
            decoration: BoxDecoration(
              color: (index + 1 == _getWeightTargetC.weight.value)
                  ? AppColors.mailColor
                  : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 3, color: AppColors.primaryColor),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_getWeightTargetC.list[index]}',
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
                      'What is your target weight?',
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
                      itemCount: _getWeightTargetC.list.length,
                      onItemFocus: (int) {
                        _getWeightTargetC.weight.value = int + 1;
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BoxData(
                          text: '${_getWeightTargetC.weight.value}kg',
                          widthDevice: widthDevice,
                          heightDevice: heightDevice),
                      BoxData(
                        text:
                            '${(_getWeightTargetC.weight.value * 2.20462262).round()}lbs',
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
                press: () => _getWeightTargetC.nextBtnClick(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

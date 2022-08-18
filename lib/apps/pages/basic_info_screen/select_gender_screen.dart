import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/basic_controller/select_gender_controller.dart';

import '../../data/enums/app_enums.dart';
import '../../global_widgets/button_custom/button_main.dart';
import '../../routes/route_name.dart';
import '../../template/misc/colors.dart';

class SelectGenderScreen extends StatelessWidget {
  final _selectGenderC = Get.find<SelectGenderC>();

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;

    return Obx(
      () => Container(
        padding: const EdgeInsets.only(bottom: 120),
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
                      'Select Your Gender',
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
              'Provide your gender so that we can choose the most conform exercise for you. ',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: widthDevice * 0.3,
                  width: widthDevice * 0.3,
                  decoration: BoxDecoration(
                    color: AppColors.mailColor,
                    border: _selectGenderC.select.value == Gender.male
                        ? Border.all(width: 2.5, color: Colors.black)
                        : null,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () => _selectGenderC.select.value = Gender.male,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/Male.png',
                          width: 50,
                          height: 50,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            'Male',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sen',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: widthDevice * 0.3,
                  width: widthDevice * 0.3,
                  decoration: BoxDecoration(
                    color: AppColors.femailColor,
                    border: _selectGenderC.select.value == Gender.female
                        ? Border.all(width: 2.5, color: Colors.black)
                        : null,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () => _selectGenderC.select.value = Gender.female,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/Female.png',
                          width: 50,
                          height: 50,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 6.0),
                          child: Text(
                            'Female',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sen',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: ButtonDesign(
                title: 'Next',
                press: () => _selectGenderC.nextBtnClick(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

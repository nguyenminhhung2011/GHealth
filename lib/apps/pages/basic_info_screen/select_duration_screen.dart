import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/pages/basic_info_screen/get_weight_screen.dart';
import 'package:gold_health/apps/pages/basic_info_screen/widgets/select_duration_button.dart';

import '../../controls/select_durationControls.dart';
import '../../global_widgets/buttonMain.dart';
import '../../routes/routeName.dart';
import '../../template/misc/colors.dart';

enum Times {
  sometimes,
  usually,
  always,
}

class SelectDurationScreen extends StatefulWidget {
  @override
  State<SelectDurationScreen> createState() => _SelectDurationScreenState();
}

class _SelectDurationScreenState extends State<SelectDurationScreen> {
  bool check = false;
  Times? _selecting;
  final _selectDuration = Get.find<SelectDurationC>();
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
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: heightDevice / 20),
            Row(
              children: [
                IconButton(
                  color: Colors.black,
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Get.back(),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.only(right: 40),
                    alignment: Alignment.center,
                    child: Text(
                      'How many time in week you exercise?',
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
            const SizedBox(height: 40),
            Column(
              children: [
                SelectDurationButton(
                  isSelected: _selecting == Times.sometimes,
                  press: () {
                    setState(() {
                      _selecting = Times.sometimes;
                    });
                  },
                  times: '2-3 Times in week',
                  cap: 'Sometimes',
                ),
                const SizedBox(height: 10),
                SelectDurationButton(
                  isSelected: _selecting == Times.usually,
                  press: () {
                    setState(() {
                      _selecting = Times.usually;
                    });
                  },
                  times: '5 Days in week',
                  cap: 'Usually',
                ),
                const SizedBox(height: 10),
                SelectDurationButton(
                  isSelected: _selecting == Times.always,
                  press: () {
                    setState(() {
                      _selecting = Times.always;
                    });
                  },
                  times: '7 Days in week',
                  cap: 'Always',
                ),
              ],
            ),
            Spacer(),
            ButtonDesign(
                title: 'Next',
                press: () {
                  Get.toNamed(RouteName.getOld);
                }),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/pages/basic_info_screen/get_weight_screen.dart';
import 'package:gold_health/apps/pages/basic_info_screen/widgets/select_duration_button.dart';

import '../../controls/select_durationControls.dart';
import '../../data/enums/app_enums.dart';
import '../../global_widgets/buttonMain.dart';
import '../../routes/routeName.dart';
import '../../template/misc/colors.dart';

class SelectDurationScreen extends StatelessWidget {
  SelectDurationScreen({Key? key}) : super(key: key);
  final _selectDuration = Get.find<SelectDurationC>();

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;

    return Obx(
      () => Scaffold(
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
                    isSelected: _selectDuration.duration.value == Times.notmuch,
                    press: () {
                      _selectDuration.duration.value = Times.notmuch;
                    },
                    times: 'Not much ',
                    cap: 'Not Much or none',
                  ),
                  const SizedBox(height: 10),
                  SelectDurationButton(
                    isSelected: _selectDuration.duration.value == Times.little,
                    press: () {
                      _selectDuration.duration.value = Times.little;
                    },
                    times: 'A Little',
                    cap: '2 - 3 days in week',
                  ),
                  const SizedBox(height: 10),
                  SelectDurationButton(
                    isSelected: _selectDuration.duration.value == Times.medium,
                    press: () {
                      _selectDuration.duration.value = Times.medium;
                    },
                    times: 'Medium',
                    cap: '3 - 5 days in week',
                  ),
                  const SizedBox(height: 10),
                  SelectDurationButton(
                    isSelected: _selectDuration.duration.value == Times.many,
                    press: () {
                      _selectDuration.duration.value = Times.many;
                    },
                    times: 'Many',
                    cap: '6  - 7 days in week',
                  ),
                  const SizedBox(height: 10),
                  SelectDurationButton(
                    isSelected: _selectDuration.duration.value == Times.somany,
                    press: () {
                      _selectDuration.duration.value = Times.somany;
                    },
                    times: 'So Many',
                    cap: 'Works every day of the week',
                  ),
                ],
              ),
              const Spacer(),
              ButtonDesign(
                title: 'Next',
                press: () => _selectDuration.nextBtnClick(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gold_health/apps/controls/basic_controller/get_old_controller.dart';
import '../../global_widgets/button_custom/button_main.dart';
import 'package:get/get.dart';
import '../../template/misc/colors.dart';

class GetOldScreen extends StatefulWidget {
  const GetOldScreen({Key? key}) : super(key: key);

  @override
  State<GetOldScreen> createState() => _GetOldScreenState();
}

class _GetOldScreenState extends State<GetOldScreen> {
  var list = [for (var i = 10; i <= 100; i++) i];
  DateTime timeTemp = DateTime.now();

  int age = 10;
  final _getOldC = Get.put(GetOldC());

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    return Container(
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
                    'How old are you?',
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
                  child: Text.rich(
                    TextSpan(
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                        children: [
                          const TextSpan(
                            text: 'Date Born: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: age.toString(),
                            style:
                                const TextStyle(color: AppColors.primaryColor),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (value) {
                      _getOldC.timePicker = value;
                    },
                    initialDateTime: DateTime.now(),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ButtonDesign(
              title: 'Next',
              press: () => _getOldC.nextBtnClick(),
            ),
          ),
        ],
      ),
    );
  }
}

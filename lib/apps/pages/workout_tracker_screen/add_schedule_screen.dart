import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../global_widgets/screenTemplate.dart';
import '../dashboard/widgets/button_gradient.dart';
import './onClick_schedule.dart' show Meeting;

class AddScheduleScreen extends StatefulWidget {
  final DateTime dateTime;
  const AddScheduleScreen({Key? key, required this.dateTime}) : super(key: key);

  @override
  State<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  Map<String, Map<String, dynamic>> data = {
    'Choose Workout': {
      'icon': 'assets/icons/barbel_1.svg',
      'listDropDownValue': [
        'Upperbody Workout',
        'Lowerbody Workout',
        'Cardio',
        'Chest',
        'ABS',
      ],
    },
    'Difficulty': {
      'icon': 'assets/icons/Icon-Swap.svg',
      'listDropDownValue': [
        'Beginner',
        'Intermediate',
        'Upper Intermediate',
        'Hard',
        'Super Hard',
      ],
    },
    'Custom Repetitions': {
      'icon': 'assets/icons/Icon-Repetitions.svg',
      'listDropDownValue': [
        '10',
        '15',
        '20',
        '25',
        '30',
        '35',
        '40',
        '45',
      ],
    },
    'Custom Weights': {
      'icon': 'assets/icons/Icon-Weight.svg',
      'listDropDownValue': [
        '10 kg',
        '15 kg',
        '20 kg',
        '25 kg',
        '30 kg',
        '35 kg',
        '40 kg',
        '45 kg',
      ],
    },
  };

  late String dropDownValueChooseWorkout = ((data['Choose Workout']
      as Map<String, dynamic>)['listDropDownValue'] as List<String>)[0];
  late String dropDownValueDifficulty = ((data['Difficulty']
      as Map<String, dynamic>)['listDropDownValue'] as List<String>)[0];
  late String dropDownValueCustomRepetitions = ((data['Custom Repetitions']
      as Map<String, dynamic>)['listDropDownValue'] as List<String>)[0];
  late String dropDownValueCustomWeight = ((data['Custom Weights']
      as Map<String, dynamic>)['listDropDownValue'] as List<String>)[0];

  late DateTime selectDate = DateTime(
      widget.dateTime.year,
      widget.dateTime.month,
      widget.dateTime.day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                  const Text(
                    'Add Schedule',
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz),
                  )
                ],
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  const Icon(Icons.calendar_month_outlined),
                  const SizedBox(width: 10),
                  Text(
                    DateFormat().add_yMMMEd().format(widget.dateTime),
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const Text(
                'Time',
                style: TextStyle(
                  fontFamily: 'Sen',
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                alignment: Alignment.center,
                height: Get.mediaQuery.size.height * 0.2,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  onDateTimeChanged: (value) {
                    selectDate = DateTime(
                      widget.dateTime.year,
                      widget.dateTime.month,
                      widget.dateTime.day,
                      value.hour,
                      value.minute,
                      value.second,
                    );
                  },
                  initialDateTime: DateTime.now(),
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Detail Workout',
                style: TextStyle(
                  fontFamily: 'Sen',
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: Get.mediaQuery.size.width,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[300]),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          SvgPicture.asset((data['Choose Workout']
                              as Map<String, dynamic>)['icon'] as String),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text('Choose Workout',
                                style: TextStyle(fontSize: 15)),
                          ),
                          SizedBox(
                            height: 30,
                            child: DropdownButton<String>(
                              borderRadius: BorderRadius.circular(15),
                              value: dropDownValueChooseWorkout,
                              elevation: 5,
                              icon: const Icon(Icons.arrow_drop_down_outlined),
                              items: ((data['Choose Workout'] as Map<String,
                                          dynamic>)['listDropDownValue']
                                      as List<String>)
                                  .map(
                                    (e) => DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(e,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          )),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  dropDownValueChooseWorkout = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[300]),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          SvgPicture.asset((data['Difficulty']
                              as Map<String, dynamic>)['icon'] as String),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text('Difficulty',
                                style: const TextStyle(fontSize: 15)),
                          ),
                          SizedBox(
                            height: 30,
                            child: DropdownButton<String>(
                              borderRadius: BorderRadius.circular(15),
                              value: dropDownValueDifficulty,
                              elevation: 5,
                              icon: const Icon(Icons.arrow_drop_down_outlined),
                              items:
                                  ((data['Difficulty'] as Map<String, dynamic>)[
                                          'listDropDownValue'] as List<String>)
                                      .map(
                                        (e) => DropdownMenuItem<String>(
                                          value: e,
                                          child: Text(e,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54,
                                              )),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  dropDownValueDifficulty = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[300]),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          SvgPicture.asset((data['Custom Repetitions']
                              as Map<String, dynamic>)['icon'] as String),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text('Custom Repetitions',
                                style: const TextStyle(fontSize: 15)),
                          ),
                          SizedBox(
                            height: 30,
                            child: DropdownButton<String>(
                              borderRadius: BorderRadius.circular(15),
                              value: dropDownValueCustomRepetitions,
                              elevation: 5,
                              icon: const Icon(Icons.arrow_drop_down_outlined),
                              items: ((data['Custom Repetitions'] as Map<String,
                                          dynamic>)['listDropDownValue']
                                      as List<String>)
                                  .map(
                                    (e) => DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(e,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          )),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  dropDownValueCustomRepetitions = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[300]),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          SvgPicture.asset((data['Custom Weights']
                              as Map<String, dynamic>)['icon'] as String),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text('Custom Weights',
                                style: const TextStyle(fontSize: 15)),
                          ),
                          SizedBox(
                            height: 30,
                            child: DropdownButton<String>(
                              borderRadius: BorderRadius.circular(15),
                              value: dropDownValueCustomWeight,
                              elevation: 5,
                              icon: const Icon(Icons.arrow_drop_down_outlined),
                              items: ((data['Custom Weights'] as Map<String,
                                          dynamic>)['listDropDownValue']
                                      as List<String>)
                                  .map(
                                    (e) => DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  dropDownValueCustomWeight = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Center(
                child: ButtonGradient(
                  height: Get.mediaQuery.size.height * 0.06,
                  width: Get.mediaQuery.size.width * 0.9,
                  linearGradient: LinearGradient(colors: [
                    Colors.blue[200]!,
                    Colors.blue[300]!,
                    Colors.blue[400]!
                  ]),
                  onPressed: () {
                    Function(Meeting) addMeeting =
                        Get.arguments as Function(Meeting);
                    print(selectDate.toIso8601String());
                    addMeeting(
                      Meeting(
                        eventName: dropDownValueChooseWorkout,
                        from: selectDate,
                        to: selectDate
                            .add(const Duration(hours: 1, minutes: 30)),
                        background: Colors.black,
                        isAllDay: false,
                      ),
                    );
                    Get.back();
                  },
                  title: const Text(
                    'Save',
                    style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

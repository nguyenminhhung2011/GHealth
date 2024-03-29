import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/workout_controller/workout_plan_controller.dart';
import 'package:intl/intl.dart';

import '../../../services/notification.dart';
import '../dashboard/widgets/button_gradient.dart';
import 'workout_schedule_screen.dart' show Meeting;

class AddScheduleScreen extends StatefulWidget {
  final DateTime dateTime;
  const AddScheduleScreen({Key? key, required this.dateTime}) : super(key: key);

  @override
  State<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  var _isLoading = false.obs;
  final _workoutController = Get.find<WorkoutPlanController>();
  Map<String, Map<String, dynamic>> data = {
    'Choose Workout': {
      'icon': 'assets/icons/barbel_1.svg',
      'listDropDownValue': [
        'Upperbody',
        'Lowebody',
        'Fullbody',
        'Cardio',
        'Hitt',
        'Abs',
      ],
    },
    'Difficulty': {
      'icon': 'assets/icons/Icon-Swap.svg',
      'listDropDownValue': [
        'Beginner',
        'Intermediate',
        'Advance',
      ],
    },
    'Custom Duration': {
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
  };

  late String dropDownValueChooseWorkout = ((data['Choose Workout']
      as Map<String, dynamic>)['listDropDownValue'] as List<String>)[0];
  late String dropDownValueDifficulty = ((data['Difficulty']
      as Map<String, dynamic>)['listDropDownValue'] as List<String>)[0];
  late String dropDownValueCustomRepetitions = ((data['Custom Duration']
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
                                style: TextStyle(fontSize: 15)),
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
                          SvgPicture.asset((data['Custom Duration']
                              as Map<String, dynamic>)['icon'] as String),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text('Custom Duration',
                                style: TextStyle(fontSize: 15)),
                          ),
                          SizedBox(
                            height: 30,
                            child: DropdownButton<String>(
                              borderRadius: BorderRadius.circular(15),
                              value: dropDownValueCustomRepetitions,
                              elevation: 5,
                              icon: const Icon(Icons.arrow_drop_down_outlined),
                              items: ((data['Custom Duration'] as Map<String,
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
                                style: TextStyle(fontSize: 15)),
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
                child: _isLoading.value
                    ? const CircularProgressIndicator()
                    : ButtonGradient(
                        height: Get.mediaQuery.size.height * 0.06,
                        width: Get.mediaQuery.size.width * 0.9,
                        linearGradient: LinearGradient(colors: [
                          Colors.blue[200]!,
                          Colors.blue[300]!,
                          Colors.blue[400]!
                        ]),
                        onPressed: () async {
                          try {
                            _isLoading.value = true;
                            final response =
                                await _workoutController.addWorkoutSchedule({
                              'isFinish': false,
                              'isTurnOn': true,
                              'level': 'Intermediate',
                              'duration': dropDownValueCustomRepetitions,
                              'workoutCategory': dropDownValueChooseWorkout,
                              'time': Timestamp.fromDate(selectDate),
                              'weight': dropDownValueCustomWeight,
                            });
                            Function(Meeting) addMeeting =
                                Get.arguments as Function(Meeting);
                            addMeeting(
                              Meeting(
                                id: response,
                                eventName: dropDownValueChooseWorkout,
                                from: selectDate,
                                to: selectDate
                                    .add(const Duration(hours: 1, minutes: 30)),
                                background: Colors.black,
                                isAllDay: false,
                              ),
                            );

                            await createWorkoutNotificationAuto(
                              NotificationCalendar.fromDate(
                                  date: selectDate
                                      .add(const Duration(seconds: 5))),
                            );
                            _isLoading.value = false;
                            Get.back();
                          } catch (e) {
                            debugPrint(e.toString());
                            rethrow;
                          }
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

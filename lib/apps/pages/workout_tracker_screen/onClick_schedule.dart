import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../template/misc/colors.dart';
import 'package:intl/intl.dart';

class OnClickScheduleScreen extends StatefulWidget {
  const OnClickScheduleScreen({Key? key}) : super(key: key);

  @override
  State<OnClickScheduleScreen> createState() => _OnClickScheduleScreenState();
}

class _OnClickScheduleScreenState extends State<OnClickScheduleScreen> {
  var now = DateTime.now().obs;
  Timer? timer;
  final List<DateTime> listDateTime = [
    for (int i = 1; i <= 30; i++)
      DateTime(2022, 8, 1).subtract(Duration(days: i)),
    for (int i = 0; i <= 30; i++) DateTime(2022, 8, 1).add(Duration(days: i))
  ];
  GlobalKey<ScrollSnapListState> sslKey = GlobalKey();
  late int onFocus;
  final CalendarController _calendarController = CalendarController();

  Widget _itemBuilder(BuildContext context, int index) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10),
      width: 80,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: onFocus == index
            ? LinearGradient(colors: [
                Colors.blue[200]!,
                Colors.blue[300]!,
                Colors.blue[400]!
              ])
            : const LinearGradient(
                colors: [
                  Colors.white10,
                  Colors.white10,
                ],
              ),
      ),
      child: SizedBox(
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              DateFormat().add_E().format(listDateTime[index]),
              style: TextStyle(
                color: onFocus == index ? Colors.white : Colors.black,
              ),
            ),
            Text(
              DateFormat().add_d().format(listDateTime[index]),
              style: TextStyle(
                color: onFocus == index ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Meeting> _getScheduleData() {
    List<Meeting> meetings = [];
    meetings.add(Meeting(
        from: DateTime.now().subtract(const Duration(hours: 3)),
        to: DateTime.now().add(const Duration(hours: 1)),
        eventName: 'Meeting',
        isAllDay: false,
        background: Colors.black));
    meetings.add(Meeting(
        from: DateTime.now().subtract(const Duration(hours: 1)),
        to: DateTime.now().add(const Duration(hours: 1)),
        eventName: 'Meeting 2',
        isAllDay: false,
        background: Colors.black));
    // meetings.add(Meeting(
    //   startTime: DateTime.now().add(const Duration(hours: 4, days: -1)),
    //   endTime: DateTime.now().add(const Duration(hours: 5, days: -1)),
    //   eventName: 'Release Meeting',
    //   isDone: true,
    // ));
    // meetings.add(Meeting(
    //   startTime: DateTime.now().add(const Duration(hours: 2, days: -4)),
    //   endTime: DateTime.now().add(const Duration(hours: 4, days: -4)),
    //   eventName: 'Performance check',
    //   isDone: false,
    // ));
    // meetings.add(Meeting(
    //   startTime: DateTime.now().add(const Duration(hours: 11, days: -2)),
    //   endTime: DateTime.now().add(const Duration(hours: 12, days: -2)),
    //   eventName: 'Customer Meeting   Tokyo, Japan',
    //   isDone: true,
    // ));
    // meetings.add(Meeting(
    //   startTime: DateTime.now().add(const Duration(hours: 6, days: 2)),
    //   endTime: DateTime.now().add(const Duration(hours: 7, days: 2)),
    //   eventName: 'Retrospective',
    //   isDone: false,
    // ));

    return meetings;
  }

  Widget _scheduleBuilder(
      BuildContext context, CalendarAppointmentDetails details) {
    final Meeting meeting = details.appointments.first;
    return Obx(
      () => Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          RotatedBox(
            quarterTurns: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: LinearProgressIndicator(
                color: Colors.blue[300],
                backgroundColor: Colors.grey.withOpacity(0.5),
                value: (meeting.to.isBefore(now.value)
                    ? 1.0
                    : meeting.from.isAfter(now.value)
                        ? 0
                        : (now.value
                                .difference(meeting.from)
                                .inSeconds
                                .toDouble()) /
                            meeting.to.difference(meeting.from).inSeconds),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              meeting.eventName,
              style: const TextStyle(
                color: Colors.blueGrey,
                fontFamily: 'Sen',
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      now.value = DateTime.now();
    });
    for (int i = 0; i < listDateTime.length; i++) {
      if (DateFormat().add_yMd().format(listDateTime[i]) ==
          DateFormat().add_yMd().format(DateTime.now())) {
        onFocus = i;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.primaryColor1,
                            Colors.grey.withOpacity(0.1),
                          ],
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Text(
                    'Workout Schedule',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontSize: 25),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.primaryColor1,
                            Colors.grey.withOpacity(0.1),
                          ],
                        ),
                      ),
                      child: const Icon(
                        Icons.more_horiz,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        onFocus--;
                        sslKey.currentState!.focusToItem(onFocus);
                        _calendarController.displayDate = listDateTime[onFocus];
                      });
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 18,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${DateFormat().add_MMM().format(listDateTime[onFocus])} ${listDateTime[onFocus].year}',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        onFocus++;
                        sslKey.currentState!.focusToItem(onFocus);
                        _calendarController.displayDate = listDateTime[onFocus];
                      });
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 18,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.17,
                child: ScrollSnapList(
                  key: sslKey,
                  itemBuilder: _itemBuilder,
                  background: Colors.blue[200],
                  itemCount: listDateTime.length,
                  itemSize: 100,
                  dispatchScrollNotifications: true,
                  initialIndex: onFocus.toDouble(),
                  scrollPhysics: const ScrollPhysics(),
                  duration: 1000,
                  onItemFocus: (int index) {
                    setState(() {
                      onFocus = index;
                      _calendarController.displayDate = listDateTime[onFocus];
                    });
                  },
                ),
              ),
              SizedBox(
                height: heightDevice + 100,
                child: SfCalendar(
                  initialDisplayDate: listDateTime[onFocus],
                  controller: _calendarController,
                  viewNavigationMode: ViewNavigationMode.none,
                  allowAppointmentResize: true,
                  view: CalendarView.day,
                  headerHeight: 0,
                  viewHeaderHeight: 0,
                  dataSource: MeetingDataSource(_getScheduleData()),
                  appointmentBuilder: _scheduleBuilder,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _calendarController.dispose();
    timer!.cancel();
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(
      {required this.eventName,
      required this.from,
      required this.to,
      required this.background,
      required this.isAllDay});

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

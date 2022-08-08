import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/pages/list_plan_screen/dailyPlan_screen.dart';
import '../../controls/dashboard_control.dart';
import '../dashboard/home_screen.dart';
import '../progress_tracker/progress_photo_screen.dart';
import 'activity_trackerScreen.dart';
import './profileScreen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with SingleTickerProviderStateMixin {
  final _dashBoardScreenC = Get.find<DashBoardControl>();
  final Duration animDuration = const Duration(seconds: 2);
  bool isLoading = false;

  final List<Widget> listPage = [
    const HomeScreen(),
    DailyPlanScreen(),
    const ProgressPhotoScreen(),
    const ActivityTrackerScreen(),
  ];

  final List<IconData> _iconList = [
    Icons.home_outlined,
    Icons.local_activity_outlined,
    Icons.camera_alt_outlined,
    Icons.person_outline,
  ];

  bool isPressButton = false;

  Future<Widget> refreshPage() async {
    final result = await Future<Widget>.delayed(
        const Duration(milliseconds: 600),
        () => listPage[_dashBoardScreenC.tabIndex.value]);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return snapshot.data as Widget;
          }
        },
        future: refreshPage(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_activity_outlined,
            ),
            label: 'Planner',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_alt_outlined,
            ),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
            ),
            label: 'Person',
          )
        ],
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.blue[300],
        unselectedItemColor: Colors.grey,
        currentIndex: _dashBoardScreenC.tabIndex.value,
        elevation: 10,
        onTap: (value) => setState(() {
          _dashBoardScreenC.tabIndex.value = value;
        }),
      ),
    );
  }
}

import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controls/dashboard_control.dart';
import '../dashboard/home_screen.dart';
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
    const ActivityTrackerScreen(),
    Center(
      child: Container(
        height: 100,
        width: 100,
        color: Colors.red,
      ),
    ),
    const ProfileScreen(),
  ];

  final List<IconData> _iconList = [
    Icons.home_outlined,
    Icons.local_activity_outlined,
    Icons.camera_alt_outlined,
    Icons.person_outline,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : listPage[_dashBoardScreenC.tabIndex.value],
      floatingActionButton: Container(
        height: 65,
        width: 65,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[100]!, Colors.blue[200]!],
          ),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: _iconList,
        activeIndex: _dashBoardScreenC.tabIndex.value,
        onTap: (index) async {
          _dashBoardScreenC.tabIndex.value = index;
          isLoading = true;
          setState(() {});
          await Future<dynamic>.delayed(
            animDuration,
            () => setState(
              () {
                isLoading = false;
              },
            ),
          );
        },
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        blurEffect: true,
        activeColor: Colors.purple.withOpacity(0.5),
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
      ),
    );
  }
}

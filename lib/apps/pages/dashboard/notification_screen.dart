import 'dart:math';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:gold_health/apps/pages/dashboard/widgets/my_flutter_app_icons.dart';

import '../../template/misc/colors.dart';

class NotifiCationScreen extends StatelessWidget {
  NotifiCationScreen({Key? key}) : super(key: key);

  Map<DateTime, Map<String, dynamic>> notifications = {
    DateTime.now().subtract(const Duration(minutes: 5)): {
      'icon': const Icon(Icons.cake),
      'title': 'Hey, it\'s time for lunch',
    },
    DateTime.now().subtract(const Duration(hours: 2)): {
      'icon': const Icon(Icons.cake),
      'title': 'Don\'t miss your abs workout',
    },
    DateTime.now().subtract(const Duration(hours: 6)): {
      'icon': const Icon(Icons.cake),
      'title': 'Hey, let\'t add some meal for your body',
    },
    DateTime.now().subtract(const Duration(days: 10)): {
      'icon': const Icon(Icons.cake),
      'title': 'Congratulation, you have finished your workout',
    },
    DateTime.now().subtract(const Duration(days: 50)): {
      'icon': const Icon(Icons.cake),
      'title': 'Hey, it\'s time for lunch',
    },
    DateTime.now().subtract(const Duration(days: 100)): {
      'icon': const Icon(Icons.cake),
      'title': 'Ups, You have missed your lowerbody workout',
    },
  };

  List<Dismissible> listTitle = [];

  @override
  Widget build(BuildContext context) {
    notifications.forEach(
      (key, value) {
        String title = notifications[key]!['title'] as String;
        if (title.length > 27) {
          title = '${title.substring(0, 26)}...';
        }
        listTitle.add(
          Dismissible(
            key: ValueKey(key),
            background: Container(
              margin: const EdgeInsets.all(7),
              alignment: Alignment.centerRight,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.black26,
              ),
              child: const Icon(
                Icons.delete,
                size: 45,
                color: Colors.white,
              ),
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (dismiss) => notifications.remove(key),
            child: ListTile(
              isThreeLine: true,
              leading: notifications[key]!['icon'] as Icon,
              title: Text(title),
              subtitle: Text(key.toIso8601String()),
              trailing: const Icon(Icons.more_vert),
            ),
          ),
        );
      },
    );
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
        height: heightDevice,
        width: widthDevice,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: heightDevice / 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  color: Colors.black,
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Notification',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Expanded(
              child: ListView(
                children: listTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

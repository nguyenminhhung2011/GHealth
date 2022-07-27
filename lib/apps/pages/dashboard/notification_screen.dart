import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../template/misc/colors.dart';

class NotifiCationScreen extends StatelessWidget {
  NotifiCationScreen({Key? key}) : super(key: key);

  Map<DateTime, Map<String, dynamic>> notifications = {
    DateTime.now().subtract(const Duration(minutes: 5)): {
      'icon': CircleAvatar(
        child: SvgPicture.asset(
          'assets/icons/cake_2.svg',
        ),
      ),
      'title': 'Hey, it\'s time for lunch',
    },
    DateTime.now().subtract(const Duration(hours: 2)): {
      'icon': CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 230, 211, 233),
        child: SvgPicture.asset(
          'assets/icons/woman_workout.svg',
        ),
      ),
      'title': 'Don\'t miss your abs workout',
    },
    DateTime.now().subtract(const Duration(hours: 6)): {
      'icon': CircleAvatar(
        child: SvgPicture.asset(
          'assets/icons/cake.svg',
        ),
      ),
      'title': 'Hey, let\'t add some meal for your body',
    },
    DateTime.now().subtract(const Duration(days: 10)): {
      'icon': CircleAvatar(
        child: SvgPicture.asset(
          'assets/icons/man_workout.svg',
        ),
      ),
      'title': 'Congratulation, you have finished your workout',
    },
    DateTime.now().subtract(const Duration(days: 50)): {
      'icon': CircleAvatar(
        child: SvgPicture.asset(
          'assets/icons/cake.svg',
        ),
      ),
      'title': 'Hey, it\'s time for lunch',
    },
    DateTime.now().subtract(const Duration(days: 100)): {
      'icon': CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 230, 211, 233),
        child: SvgPicture.asset(
          'assets/icons/cake.svg',
        ),
      ),
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
              leading: notifications[key]!['icon'] as Widget,
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
            const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 30),
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
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.approxWhite,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Notification',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primaryColor.withOpacity(0.2),
                    ),
                    child: const Icon(
                      Icons.more_horiz,
                      color: Colors.black,
                    ),
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

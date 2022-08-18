import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../template/misc/colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controls/home_screen_controller.dart';

class NotifiCationScreen extends StatelessWidget {
  NotifiCationScreen({Key? key}) : super(key: key);
  var homeScreenController = Get.find<HomeScreenControl>();
  @override
  Widget build(BuildContext context) {
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
                      color: AppColors.approxWhite,
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
              child: ListView.builder(
                itemBuilder: (context, index) {
                  DateTime key = homeScreenController.notifications.entries
                      .elementAt(index)
                      .key;
                  String title = homeScreenController
                      .notifications[key]!['title'] as String;
                  if (title.length > 27) {
                    title = '${title.substring(0, 26)}...';
                  }

                  Duration time = DateTime.now().difference(key);
                  String? subTimeTitle;
                  if (time.inSeconds < 60) {
                    subTimeTitle =
                        'About ${time.inSeconds.toString()} seconds ago';
                  } else if (time.inMinutes < 60) {
                    subTimeTitle =
                        'About ${time.inMinutes.toString()} minutes ago';
                  } else if (time.inHours < 24) {
                    subTimeTitle = 'About ${time.inHours.toString()} hours ago';
                  } else if (time.inDays == 1) {
                    subTimeTitle = 'Yesterday';
                  } else {
                    subTimeTitle = DateFormat.MMMEd().format(key);
                  }
                  return Dismissible(
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
                    onDismissed: (dismiss) =>
                        homeScreenController.deleteNotification(key),
                    child: ListTile(
                      isThreeLine: true,
                      leading: homeScreenController.notifications[key]!['icon']
                          as Widget,
                      title: Text(title),
                      subtitle: Text(
                        subTimeTitle,
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontSize: 13),
                      ),
                      trailing: const Icon(Icons.more_vert),
                    ),
                  );
                },
                itemCount: homeScreenController.notifications.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

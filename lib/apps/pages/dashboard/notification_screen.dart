import 'package:flutter/material.dart';
import 'package:gold_health/apps/controls/acti_history_controller.dart';
import '../../template/misc/colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controls/home_screen_controller.dart';

class NotifiCationScreen extends StatelessWidget {
  NotifiCationScreen({Key? key}) : super(key: key);
  final controller = Get.find<ActiHistoriC>();
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
                    'Activity History',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                InkWell(
                  onTap: () {
                    print(controller.listActi);
                  },
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
            Obx(
              () => controller.listActi.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          DateTime key = controller.listActi[index]['date'];
                          String title = controller.listActi[index]['type'] == 0
                              ? 'You drank ${controller.listActi[index]['consume']} of water'
                              : controller.listActi[index]['type'] == 1
                                  ? 'You have absorbed ${controller.listActi[index]['kCalConsume']} Calories'
                                  : 'You have burned ${controller.listActi[index]['kCalBurn']} Calories';
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
                            subTimeTitle =
                                'About ${time.inHours.toString()} hours ago';
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: AppColors.primaryColor1,
                              ),
                              child: const Icon(
                                Icons.delete,
                                size: 45,
                                color: Colors.white,
                              ),
                            ),
                            direction: DismissDirection.endToStart,
                            onDismissed: (dismiss) =>
                                controller.deleteActiFromFirebase(
                                    controller.listActi[index]['id']),
                            child: ListTile(
                              isThreeLine: true,
                              // leading: homeScreenController.notifications[key]!['icon']
                              //     as Widget,
                              leading: IconLeading(
                                  check: controller.listActi[index]['type']),
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
                        itemCount: controller.listActi.length,
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/notfound.png',
                              height: 50, width: 50),
                          const Text(
                            'You don\'t have activity',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class IconLeading extends StatelessWidget {
  const IconLeading({super.key, required this.check});
  final int check;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: check == 2
            ? AppColors.primaryColor2.withOpacity(0.2)
            : check == 0
                ? AppColors.primaryColor1.withOpacity(0.2)
                : AppColors.primaryColor.withOpacity(0.2),
      ),
      child: Image.asset(check == 0
          ? 'assets/images/drinking.png'
          : check == 1
              ? 'assets/images/eating.png'
              : 'assets/icons/Ellipse (3).png'),
    );
  }
}

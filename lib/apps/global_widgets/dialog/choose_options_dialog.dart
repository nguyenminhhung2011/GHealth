import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../template/misc/colors.dart';

class ChooseOptionsDialog extends StatelessWidget {
  const ChooseOptionsDialog({
    Key? key,
    required this.press1,
    required this.question,
    required this.title1,
    required this.title2,
    required this.press2,
  }) : super(key: key);

  final Function() press1;
  final Function() press2;
  final String question;
  final String title1;
  final String title2;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Badge(
        position: BadgePosition.topStart(
          top: -45,
          start: (Get.mediaQuery.size.width * 0.8) / 2 - 45,
        ),
        badgeColor: Colors.white,
        padding: const EdgeInsets.all(10),
        stackFit: StackFit.passthrough,
        elevation: 0,
        badgeContent: CircleAvatar(
          radius: 35,
          backgroundColor: Colors.blueGrey[50],
          child: Image.asset(
            'assets/images/flag.png',
            height: 35,
            width: 35,
          ),
        ),
        child: SizedBox(
          height: Get.mediaQuery.size.height * 0.37,
          width: Get.mediaQuery.size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: press1,
                      style: ElevatedButton.styleFrom(
                          primary: AppColors.primaryColor1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          fixedSize: const Size(110, 50),
                          elevation: 0),
                      child: Text(
                        title1,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(width: 15),
                  ElevatedButton(
                      onPressed: press2,
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.primaryColor1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        fixedSize: const Size(110, 50),
                        elevation: 0,
                      ),
                      child: Text(
                        title2,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

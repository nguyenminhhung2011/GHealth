import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    Key? key,
    required this.question,
    required this.title1,
  }) : super(key: key);

  final String question;
  final String title1;
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
            'assets/images/error.png',
            height: 35,
            width: 35,
          ),
        ),
        child: SizedBox(
          height: Get.mediaQuery.size.height * 0.3,
          width: Get.mediaQuery.size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Spacer(),
              Text(
                question,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                width: Get.mediaQuery.size.width * 0.7,
                child: Text(
                  title1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        fixedSize: const Size(110, 50),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Yes',
                        style: TextStyle(
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

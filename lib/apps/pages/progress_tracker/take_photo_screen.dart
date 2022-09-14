import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controls/progress_controller/progress_controller.dart';
import '../../template/misc/colors.dart';

/// CameraApp is the Main Application.
// ignore: must_be_immutable
class TakePhotoScreen extends StatefulWidget {
  /// Default Constructor
  List<Map<String, dynamic>> fakeDta;

  TakePhotoScreen({Key? key, required this.fakeDta}) : super(key: key);
  @override
  State<TakePhotoScreen> createState() => _TakePhotoScreenState();
}

class _TakePhotoScreenState extends State<TakePhotoScreen>
    with TickerProviderStateMixin {
  final controller = Get.find<ProgressC>();
  bool isLoading = false;
  @override
  // void dispose() {
  //   controller.disposeAll();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProgressC>(
      init: ProgressC(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.mainColor,
        body: Column(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                color: AppColors.primaryColor1,
                child: Stack(
                  children: [
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: controller.listImage[controller.onFocus.value] !=
                                null
                            ? Image.file(
                                controller.listImage[controller.onFocus.value]!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(controller
                                    .basicListImage[controller.onFocus.value]
                                ['image']),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(height: 60),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => Get.back(),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  final result =
                                      await dialogCalender(context, controller);
                                  if (result != null && result == true) {
                                    // controller.disposeAll();
                                    // Get.back();
                                    Get.snackbar(
                                      'Progress',
                                      'Wait to upload Image ',
                                      colorText: AppColors.primaryColor1,
                                      backgroundColor: Colors.white,
                                    );
                                    controller.isLoading.value = true;
                                    controller.update();
                                    controller
                                        .upProressToFirebase(
                                            controller.datePicker.value)
                                        .then((value) {
                                      if (value == 'Upload Image sucess') {
                                        controller.isLoading.value = false;
                                        Get.back();
                                      }
                                    });
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.save,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            width: 200,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: AppColors.mainColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  offset: const Offset(2, 3),
                                  blurRadius: 20,
                                ),
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  offset: const Offset(-2, -3),
                                  blurRadius: 20,
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () => controller.pickImageCamera(),
                                  icon: SvgPicture.asset(
                                      'assets/icons/Camera.svg'),
                                ),
                                Container(
                                  height: 50,
                                  width: 0.4,
                                  color: Colors.grey,
                                ),
                                IconButton(
                                  onPressed: () =>
                                      controller.pickImageGallery(),
                                  icon: SvgPicture.asset(
                                      'assets/icons/Image.svg'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                    controller.isLoading.value
                        ? SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.0)),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                      color: AppColors.primaryColor1),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            Obx(
              () => Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: AppColors.mainColor,
                  alignment: Alignment.center,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: controller.basicListImage.map((e) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                controller.onFocus.value = e['index'];
                                controller.update();
                              },
                              child: Container(
                                width: 80,
                                height: 80,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    width: 2,
                                    color:
                                        (controller.onFocus.value == e['index'])
                                            ? Colors.black
                                            : Colors.transparent,
                                  ),
                                ),
                                child: (controller.listImage[e['index']] !=
                                        null)
                                    ? Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(
                                              controller.listImage[e['index']]!,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Image.asset(e['image']),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              e['title'],
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            )
                          ],
                        );
                      }).toList()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> dialogCalender(BuildContext context, ProgressC controller) {
    DateTime timeTemp = DateTime.now();
    return showModalBottomSheet(
      context: context,
      transitionAnimationController: AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 400,
        ),
      ),
      builder: (context) => Container(
        height: 260,
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        child: Column(
          children: [
            // ignore: avoid_unnecessary_containers
            SizedBox(
              height: 180,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (value) {
                  timeTemp = value;
                },
                initialDateTime: DateTime.now(),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        var count = controller.listImage
                            .where((element) => element == null)
                            .toList()
                            .length;
                        if (count == 0) {
                          controller.datePicker.value = timeTemp;
                          Get.back(result: true);
                        } else {
                          Get.back(result: false);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.primaryColor1),
                        child: !controller.isLoading.value
                            ? const Text(
                                'Save',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

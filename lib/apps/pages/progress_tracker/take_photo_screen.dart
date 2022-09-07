import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

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
  List<File?> listImage = [null, null, null, null];
  int onFocus = 0;
  List<Map<String, dynamic>> basicListImage = [
    {
      'title': 'Front',
      'image': 'assets/images/front.png',
      'index': 0,
    },
    {
      'title': 'Left',
      'image': 'assets/images/front.png',
      'index': 1,
    },
    {
      'title': 'Back',
      'image': 'assets/images/front.png',
      'index': 2,
    },
    {
      'title': 'Right',
      'image': 'assets/images/front.png',
      'index': 3,
    }
  ];

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.listImage[onFocus] = imageTemp);
    } catch (e) {
      // ignore: avoid_print
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.listImage[onFocus] = imageTemp);
    } catch (e) {
      // ignore: avoid_print
      print('Failed to pick image: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    listImage.clear();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              color: AppColors.primaryColor1,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: listImage[onFocus] != null
                        ? Image.file(
                            listImage[onFocus]!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(basicListImage[onFocus]['image']),
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
                              onTap: () {
                                Navigator.of(context).pop();
                              },
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
                                DateTime timeTemp = DateTime.now();
                                await showModalBottomSheet(
                                  context: context,
                                  transitionAnimationController:
                                      AnimationController(
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
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    var count = listImage
                                                        .where((element) =>
                                                            element == null)
                                                        .toList()
                                                        .length;
                                                    (count > 0)
                                                        ? widget.fakeDta.add({
                                                            'm': timeTemp.month,
                                                            'd': timeTemp.day,
                                                            'image': [
                                                              'assets/images/work1.png',
                                                              'assets/images/work2.png',
                                                              'assets/images/work3.png',
                                                              'assets/images/work4.png',
                                                            ],
                                                            'type': 0,
                                                          })
                                                        : widget.fakeDta.add({
                                                            'm': timeTemp.month,
                                                            'd': timeTemp.day,
                                                            'image': listImage,
                                                            'type': 1,
                                                          });
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color: AppColors
                                                            .primaryColor1),
                                                    child: const Text(
                                                      'Save',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
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
                                onPressed: () {
                                  pickImageC();
                                },
                                icon:
                                    SvgPicture.asset('assets/icons/Camera.svg'),
                              ),
                              Container(
                                height: 50,
                                width: 0.4,
                                color: Colors.grey,
                              ),
                              IconButton(
                                onPressed: () {
                                  pickImage();
                                },
                                icon:
                                    SvgPicture.asset('assets/icons/Image.svg'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: AppColors.mainColor,
              alignment: Alignment.center,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: basicListImage.map((e) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            setState(() {
                              onFocus = e['index'];
                            });
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
                                color: (onFocus == e['index'])
                                    ? Colors.black
                                    : Colors.transparent,
                              ),
                            ),
                            child: (listImage[e['index']] != null)
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(
                                          listImage[e['index']]!,
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
        ],
      ),
    );
  }
}

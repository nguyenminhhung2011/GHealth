import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/fillProfilControls.dart';
import 'package:gold_health/apps/routes/routeName.dart';
import 'package:gold_health/apps/template/misc/untils.dart';
import 'package:image_picker/image_picker.dart';

import '../../controls/storage_methods.dart.dart';
import '../../global_widgets/boxData.dart';
import '../../global_widgets/buttonMain.dart';
import '../../global_widgets/textFieldWithIcon.dart';
import '../../global_widgets/textPhoneField.dart';
import '../../template/misc/colors.dart';

class FillProfileScreen extends StatefulWidget {
  const FillProfileScreen({Key? key}) : super(key: key);

  @override
  State<FillProfileScreen> createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends State<FillProfileScreen> {
  final fillProC = Get.find<FillProfileC>();
  var list = [for (var i = 100; i <= 300; i++) i];
  final TextEditingController c = TextEditingController();
  Uint8List? _image;
  @override
  // ignore: override_on_non_overriding_member
  void selectedImage() async {
    Uint8List? file = await pickImage(ImageSource.gallery);
    setState(() {
      _image = file;
    });
  }

  void nextBtnOnClick() async {
    if (fillProC.fullName.text.isNotEmpty) {
      String nickName = '';
      fillProC.nickName.text.isNotEmpty
          ? nickName = fillProC.nickName.text
          : {
              for (int i = 0; i < fillProC.fullName.text.length; i++)
                {
                  if (fillProC.fullName.text[i] != '')
                    nickName += fillProC.fullName.text[i]
                }
            };
      String fullName = fillProC.fullName.text;
      // String avtPath = '';
      // if (_image != null) {
      //   avtPath = await StorageMethods()
      //       .UpLoadImageGroupToStorage('ProfilePic', _image!);
      // }
      // fillProC.signUpC.basicProfile!.value.avtPath = avtPath;
      fillProC.signUpC.image = _image!;
      fillProC.signUpC.basicProfile!.value.name = fullName;
      //ignore: avoid_print
      print(fillProC.signUpC.basicProfile!.value.username);
      Get.toNamed(RouteName.selectGender);
    } else {
      // ignore: avoid_print
      print('Full name is not empty');
    }
  }

  Widget build(BuildContext context) {
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
              children: [
                IconButton(
                  color: Colors.black,
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.only(right: 40),
                    alignment: Alignment.center,
                    child: Text(
                      'Fill Your Profile',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'Don\'t worry you can always change it later,or you can skip it for now',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (_image == null)
                                  ? Container(
                                      width: widthDevice / 2.5,
                                      height: widthDevice / 2.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              'assets/images/avatar.png'),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: widthDevice / 2.5,
                                      height: widthDevice / 2.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: MemoryImage(_image!),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                          Positioned(
                            left: widthDevice / 2 + widthDevice / 10,
                            top: widthDevice / 2.5 - widthDevice / 8,
                            child: InkWell(
                              onTap: () async {
                                selectedImage();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Icon(Icons.edit, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 40),
                      TextFieldWithIcon(
                        hintText: 'Full Name',
                        controller: fillProC.fullName,
                        icon: Icons.account_circle_rounded,
                      ),
                      const SizedBox(height: 20),
                      TextFieldWithIcon(
                        hintText: 'Nick Name',
                        controller: fillProC.nickName,
                        icon: Icons.account_box_outlined,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              print('Click');
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    offset: const Offset(2, 3),
                                    blurRadius: 10,
                                  ),
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    offset: Offset(-2, -3),
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/vietnam.png',
                                    height: 50,
                                    width: 50,
                                  ),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                    size: 25,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: TextPhoneField(
                              hintText: 'Phone Number',
                              controller: fillProC.phoneNo,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Let\'s fill your profile',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(child: ButtonDesign1(title: 'Skip', press: () {})),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ButtonDesign(
                      title: 'Next',
                      press: () {
                        nextBtnOnClick();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

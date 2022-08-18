import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/basic_info_controller.dart';
import 'package:gold_health/apps/global_widgets/screen_template.dart';
import 'package:gold_health/apps/pages/basic_info_screen/get_height_screen.dart';
import 'package:gold_health/apps/pages/basic_info_screen/get_old_screen.dart';
import 'package:gold_health/apps/pages/basic_info_screen/get_weight_screen.dart';
import 'package:gold_health/apps/pages/basic_info_screen/select_duration_screen.dart';
import 'package:gold_health/apps/pages/basic_info_screen/select_gender_screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../template/misc/colors.dart';
import 'fill_profile.dart';

class BasicInfoScreen extends StatelessWidget {
  BasicInfoScreen({Key? key}) : super(key: key);
  final basicInfC = Get.find<BasicInfoC>();
  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: true, //
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: InkWell(
        //   onTap: () => Get.back(),
        //   child: const Icon(Icons.arrow_back_ios, color: Colors.black),
        // ),
        title: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 30,
                child: InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.arrow_back_ios, color: Colors.black),
                ),
              ),
              Obx(
                () => Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.primaryColor1,
                      size: 24,
                    ),
                    SizedBox(
                      height: 10,
                      width: 60,
                      child: Stack(
                        children: [
                          Container(
                            height: 10,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.withOpacity(0.1),
                            ),
                          ),
                          AnimatedContainer(
                            height: 10,
                            width: basicInfC.animaInfo.value,
                            duration: const Duration(milliseconds: 400),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.primaryColor1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.check_circle,
                      color: (basicInfC.animaInfo.value >= 60)
                          ? AppColors.primaryColor1
                          : Colors.grey.withOpacity(0.3),
                      size: 24,
                    ),
                    SizedBox(
                      height: 10,
                      width: 60,
                      child: Stack(
                        children: [
                          Container(
                            height: 10,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.withOpacity(0.1),
                            ),
                          ),
                          AnimatedContainer(
                            height: 10,
                            width: basicInfC.aimaGoal.value,
                            duration: const Duration(milliseconds: 400),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.primaryColor1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.check_circle,
                      color: Colors.grey.withOpacity(0.3),
                      size: 24,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 30),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.mainColor,
      body: ScreenTemplate(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(
              () => SizedBox(
                height: heightDevice,
                width: double.infinity,
                child: PageView.builder(
                  controller: basicInfC.pageController,
                  onPageChanged: basicInfC.onPageChangeUpdate,
                  itemBuilder: (contex, index) =>
                      basicInfC.listPages.value[index],
                  itemCount: basicInfC.listPages.value.length,
                ),
              ),
            )),
      ),
    );
  }
}

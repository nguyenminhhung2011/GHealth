import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/basic_controller/basic_info_controller.dart';
import 'package:gold_health/apps/global_widgets/screen_template.dart';
import '../../template/misc/colors.dart';

class BasicInfoScreen extends StatelessWidget {
  BasicInfoScreen({Key? key}) : super(key: key);
  final basicInfC = Get.find<BasicInfoC>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: true, //
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                      color: (basicInfC.aimaGoal.value >= 60)
                          ? AppColors.primaryColor1
                          : Colors.grey.withOpacity(0.3),
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
          child:
              // Obx(
              //   () => SizedBox(
              //     height: heightDevice,
              //     width: double.infinity,
              //     child: PageView.builder(
              //       controller: basicInfC.pageController,
              //       onPageChanged: basicInfC.onPageChangeUpdate,
              //       itemBuilder: (contex, index) =>
              //           basicInfC.listPages.value[index],
              //       itemCount: basicInfC.listPages.value.length,
              //     ),
              //   ),
              // ),
              Obx(() => basicInfC.getCurrentTab()),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../template/misc/colors.dart';

class FastingSaveScreen extends StatelessWidget {
  const FastingSaveScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(70)),
            child: Image.asset(
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              'assets/images/minimalism_geometric_landscape_124072_1280x720.png',
              height: Get.mediaQuery.size.height * 0.28,
              width: Get.mediaQuery.size.width,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: ListView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              scrollDirection: Axis.vertical,
              children: [
                SizedBox(height: Get.mediaQuery.size.height * 0.22),
                Container(
                  height: Get.mediaQuery.size.height * 0.35,
                  width: Get.mediaQuery.size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.red[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

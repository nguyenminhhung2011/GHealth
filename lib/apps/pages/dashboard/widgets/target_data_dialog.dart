import 'package:flutter/material.dart';
import 'package:gold_health/apps/template/misc/colors.dart';

import '../profile_screen.dart';
import 'load_height_weight.dart';

class TargetDataDialog extends StatelessWidget {
  const TargetDataDialog(
      {Key? key,
      required this.currentHeight,
      required this.currentWeight,
      required this.heightTarget,
      required this.weightTarget})
      : super(key: key);
  final double currentHeight;
  final double currentWeight;
  final double heightTarget;
  final double weightTarget;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: 310,
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Target data',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit, color: AppColors.primaryColor1),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              InforCard(title: 'Height', data: '${currentHeight}cm'),
              const Spacer(),
              InforCard(title: 'Weight', data: '${currentWeight}Kg'),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              LoadHeightWeight(
                widthDevice: MediaQuery.of(context).size.width,
                imgePath: 'assets/images/height.png',
                fData: 120,
                sData: 177,
                color: AppColors.primaryColor1,
                press: () {},
              ),
            ],
          ),
          Row(
            children: const [
              Text(
                '160cm',
                style: TextStyle(
                    color: AppColors.primaryColor1,
                    fontWeight: FontWeight.w600),
              ),
              Spacer(),
              Text(
                '180cm',
                style: TextStyle(
                    color: AppColors.primaryColor1,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              LoadHeightWeight(
                widthDevice: MediaQuery.of(context).size.width,
                imgePath: 'assets/images/weight.png',
                fData: 30,
                sData: 70,
                color: AppColors.primaryColor2,
                press: () {},
              ),
            ],
          ),
          Row(
            children: const [
              Text(
                '60kg',
                style: TextStyle(
                    color: AppColors.primaryColor2,
                    fontWeight: FontWeight.w600),
              ),
              Spacer(),
              Text(
                '80kg',
                style: TextStyle(
                    color: AppColors.primaryColor2,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

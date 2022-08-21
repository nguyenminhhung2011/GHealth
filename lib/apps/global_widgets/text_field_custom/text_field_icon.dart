import 'package:flutter/material.dart';

import '../../template/misc/colors.dart';

class TextFieldWithIcon extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  const TextFieldWithIcon({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: AppColors.primaryColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(2, 3),
            blurRadius: 10,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(-2, -3),
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: controller,
              style: const TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.w400),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

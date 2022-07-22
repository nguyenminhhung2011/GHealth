import 'package:flutter/material.dart';

import '../template/misc/colors.dart';

class TextFormFieldDesgin extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController control;
  final IconData icon;
  const TextFormFieldDesgin({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.control,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: control,
      keyboardType: TextInputType.emailAddress,
      obscureText: false,
      style: TextStyle(
          color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelStyle: TextStyle(
            color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          gapPadding: 10,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          gapPadding: 10,
        ),
        suffixIcon: IconButton(
          padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
          onPressed: () {},
          icon: Icon(
            icon,
            size: 20,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../template/misc/colors.dart';

class PasswordField extends StatefulWidget {
  final String hintText;
  final String labelText;
  final TextEditingController control;
  const PasswordField({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.control,
  }) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool checkShow = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.control,
      keyboardType: TextInputType.emailAddress,
      obscureText: checkShow,
      style: const TextStyle(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelStyle: const TextStyle(
            color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
          gapPadding: 10,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
          gapPadding: 10,
        ),
        suffixIcon: IconButton(
          padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
          onPressed: () {},
          icon: InkWell(
            onTap: () {
              setState(() {
                checkShow = !checkShow;
              });
            },
            child: Icon(
              (checkShow) ? Icons.visibility : Icons.visibility_off,
              size: 20,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}

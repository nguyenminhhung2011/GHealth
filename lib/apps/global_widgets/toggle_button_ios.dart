import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../template/misc/colors.dart';

class ToggleButtonIos extends StatefulWidget {
  ToggleButtonIos({Key? key, required this.val}) : super(key: key);
  bool val;
  @override
  State<ToggleButtonIos> createState() => _ToggleButtonIosState();
}

class _ToggleButtonIosState extends State<ToggleButtonIos> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      activeColor: AppColors.primaryColor1,
      value: widget.val,
      onChanged: (bool value) {
        setState(() {
          widget.val = value;
        });
      },
    );
  }
}

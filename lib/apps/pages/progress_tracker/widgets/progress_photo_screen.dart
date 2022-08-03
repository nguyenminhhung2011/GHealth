import 'package:flutter/material.dart';
import '../../../global_widgets/screenTemplate.dart';
import '../../../template/misc/colors.dart';

class ProgressPhotoScreen extends StatelessWidget {
  const ProgressPhotoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: ScreenTemplate(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}

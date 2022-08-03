import 'package:flutter/material.dart';

import '../template/misc/colors.dart';

class ScreenTemplate extends StatefulWidget {
  final Widget child;
  const ScreenTemplate({Key? key, required this.child}) : super(key: key);

  @override
  State<ScreenTemplate> createState() => _ScreenTemplateState();
}

class _ScreenTemplateState extends State<ScreenTemplate> {
  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    late FixedExtentScrollController _controller =
        FixedExtentScrollController();

    return Stack(
      children: [
        Container(
          width: widthDevice,
          height: heightDevice,
          decoration: BoxDecoration(
            color: AppColors.mainColor,
          ),
          child: const Align(
            alignment: Alignment.topCenter,
          ),
        ),
        // ignore: avoid_unnecessary_containers
        Container(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: ListView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(minHeight: heightDevice),
                      child: Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                        ),
                        child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: widget.child),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

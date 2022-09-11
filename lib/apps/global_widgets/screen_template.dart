import 'package:flutter/material.dart';

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
    return Stack(
      children: [
        SizedBox(
          width: widthDevice,
          height: heightDevice,
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
                          vertical: 10,
                        ),
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: widget.child,
                        ),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../controls/compare_result_controller.dart';
import '../../global_widgets/list_chart/line_chart2_line.dart';
import '../../global_widgets/screen_template.dart';
import '../../template/misc/colors.dart';

class CompareResultScreen extends StatefulWidget {
  const CompareResultScreen({Key? key}) : super(key: key);

  @override
  State<CompareResultScreen> createState() => _CompareResultScreenState();
}

class _CompareResultScreenState extends State<CompareResultScreen> {
  final controller = Get.find<CompareResultC>();
  final List<String> listVieww = [
    'Front Facing',
    'Back Facing',
    'Left Facing',
    'Right Facing',
  ];
  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        elevation: 00,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: ButtonIcon(
              press: () => Navigator.pop(context), icon: Icons.arrow_back_ios),
        ),
        title: const Text(
          'Result',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: ScreenTemplate(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              SizedBox(
                height: heightDevice + 200,
                child: PhotoTab(widthDevice, heightDevice),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container PhotoTab(double widthDevice, double heightDevice) {
    return Container(
      color: AppColors.mainColor,
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Average Progress',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              Text(
                'Good',
                style: TextStyle(
                  color: Colors.green.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: widthDevice,
            height: 18,
            child: LinearPercentIndicator(
              lineHeight: 40,
              percent: 0.8,
              progressColor: AppColors.primaryColor1,
              backgroundColor: Colors.grey.withOpacity(0.2),
              animation: true,
              animationDuration: 1000,
              barRadius: const Radius.circular(20),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                DateFormat().add_MMMEd().format(controller.progress1['date']),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Text(
                DateFormat().add_MMMEd().format(controller.progress2['date']),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: heightDevice,
            width: widthDevice,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        listVieww[index],
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageContainer(
                              imagePath: controller.progress1['listImage']
                                  [index]),
                          const SizedBox(width: 20),
                          ImageContainer(
                              imagePath: controller.progress2['listImage']
                                  [index]),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              width: widthDevice,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: AppColors.primaryColor1,
                boxShadow: [
                  // BoxShadow(
                  //   color: Colors.black.withOpacity(0.05),
                  //   offset: const Offset(2, 3),
                  //   blurRadius: 2,
                  // ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(-2, -3),
                    blurRadius: 2,
                  )
                ],
              ),
              child: const Text(
                'Back to Home',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LinePercent extends StatelessWidget {
  const LinePercent({
    Key? key,
    required this.widthDevice,
    required this.percent,
  }) : super(key: key);

  final double widthDevice;
  final double percent;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('${(percent * 100).toInt().toString()}%',
            style: const TextStyle(color: Colors.grey, fontSize: 14)),
        SizedBox(
          width: widthDevice - 100,
          height: 18,
          child: LinearPercentIndicator(
            lineHeight: 40,
            percent: percent,
            progressColor: AppColors.primaryColor1,
            backgroundColor: AppColors.primaryColor2.withOpacity(0.5),
            animation: true,
            animationDuration: 1000,
            barRadius: const Radius.circular(20),
          ),
        ),
        Text('${((1 - percent) * 100).toInt().toString()}%',
            style: const TextStyle(color: Colors.grey, fontSize: 14)),
      ],
    );
  }
}

class ButtonIcon extends StatelessWidget {
  const ButtonIcon({Key? key, required this.press, required this.icon})
      : super(key: key);
  final Function() press;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryColor1.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: Colors.black,
        ),
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  final String imagePath;

  const ImageContainer({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return (imagePath == 'assets/images/work4.png')
        ? Container(
            width: Get.width / 2.5,
            height: Get.width / 2.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(imagePath),
              ),
            ))
        : Container(
            width: Get.width / 2.5,
            height: Get.width / 2.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imagePath),
              ),
            ),
          );
  }
}

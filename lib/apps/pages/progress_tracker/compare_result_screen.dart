import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../global_widgets/list_chart/line_chart2_line.dart';
import '../../global_widgets/screen_template.dart';
import '../../template/misc/colors.dart';

class CompareResultScreen extends StatefulWidget {
  const CompareResultScreen({Key? key}) : super(key: key);

  @override
  State<CompareResultScreen> createState() => _CompareResultScreenState();
}

class _CompareResultScreenState extends State<CompareResultScreen> {
  final List<Map<String, dynamic>> fakeData = [
    {
      'm': 'June',
      'd': 2,
      'image': [
        'assets/images/work1.png',
        'assets/images/work2.png',
        'assets/images/work3.png',
        'assets/images/work4.png',
      ],
    },
    {
      'm': 'May',
      'd': 5,
      'image': [
        'assets/images/work5.png',
        'assets/images/work6.png',
        'assets/images/work7.png',
        'assets/images/work8.png',
      ],
    },
  ];
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                press: () => Navigator.pop(context),
                icon: Icons.arrow_back_ios),
          ),
          title: const Text(
            'Result',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonIcon(
                press: () {},
                icon: Icons.share,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonIcon(
                press: () {},
                icon: Icons.more_horiz,
              ),
            ),
          ],
        ),
        body: ScreenTemplate(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // ignore: avoid_unnecessary_containers
                Container(
                  height: 70,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.primaryColor1.withOpacity(0.1)),
                  child: TabBar(
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    indicator: BoxDecoration(
                      color: AppColors.primaryColor1,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    tabs: const [
                      Tab(text: 'Photo'),
                      Tab(text: 'Statisic'),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: heightDevice + 200,
                  child: TabBarView(
                    children: [
                      PhotoTab(widthDevice, heightDevice),
                      Container(
                        color: AppColors.mainColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            SizedBox(
                              width: widthDevice - 60,
                              height: 200,
                              // ignore: avoid_unnecessary_containers
                              child: Container(
                                child: const LineChartTwoLine(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  fakeData[0]['m'],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  fakeData[1]['m'],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Lose Weight',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            LinePercent(
                              widthDevice: widthDevice,
                              percent: 0.33,
                            ),
                            const SizedBox(height: 20),
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Height Increase',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            LinePercent(
                              widthDevice: widthDevice,
                              percent: 0.88,
                            ),
                            const SizedBox(height: 20),
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Muscle Mass Increase',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            LinePercent(
                              widthDevice: widthDevice,
                              percent: 0.33,
                            ),
                            const SizedBox(height: 20),
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Abs',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            LinePercent(
                              widthDevice: widthDevice,
                              percent: 0.89,
                            ),
                            const SizedBox(height: 30),
                            InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                width: widthDevice,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
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
                      ),
                    ],
                  ),
                )
              ],
            ),
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
                fakeData[0]['m'],
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Text(
                fakeData[1]['m'],
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
                          Container(
                            width: widthDevice / 2.5,
                            height: widthDevice / 2.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  fakeData[0]['image'][index],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            width: widthDevice / 2.5,
                            height: widthDevice / 2.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  fakeData[1]['image'][index],
                                ),
                              ),
                            ),
                          ),
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

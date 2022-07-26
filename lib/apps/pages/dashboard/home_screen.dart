import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';

import 'package:get/get.dart';
import 'widgets/button_gradient.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _heightDevice = MediaQuery.of(context).size.height;
    var _widthDevice = MediaQuery.of(context).size.width;
    final List<String> timeProgress = [
      '6am - 8am',
      '8am - 10am',
      '1pm - 3pm',
      '3pm - 5pm'
    ];
    final Map<String, String> litersProgress = {
      '6am - 8am': '600ml',
      '8am - 10am': '250ml',
      '1pm - 3pm': '500ml'
    };
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 10,
          left: 10,
          right: 10,
        ),
        // height: _heightDevice,
        // width: _widthDevice,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: ListTile(
                isThreeLine: true,
                title: Text(
                  'Welcome :))',
                  style: Theme.of(context).textTheme.headline5,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {},
                ),
                subtitle: Text(
                  'Hoang Truong',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
            Container(
              height: _heightDevice * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 125, 192, 248),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'BMI (Body Mass Index)',
                        style: TextStyle(
                          fontFamily: 'Sen',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'You have a normal weight',
                        style: TextStyle(
                          fontFamily: 'Sen',
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ButtonGradient(
                        width: 100,
                        height: 44,
                        linearGradient: LinearGradient(
                          colors: [Colors.purple[100]!, Colors.purple[200]!],
                        ),
                        onPressed: () {},
                        title: const Text(
                          'View More',
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 12.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25, bottom: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 232, 243, 252),
              ),
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
              ),
              height: _heightDevice * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today Target',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  ButtonGradient(
                    height: 40.0,
                    width: 90.0,
                    linearGradient: LinearGradient(
                      colors: [
                        Colors.blue[200]!,
                        Colors.blue[300]!,
                      ],
                    ),
                    onPressed: () {},
                    title: const Text(
                      'Check',
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: _heightDevice * 0.6,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Activity Status',
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Container(
                          height: _heightDevice * 0.25,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(255, 232, 243, 252),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Heart Rate in last 30 minutes',
                                  style: TextStyle(
                                    fontFamily: 'Sen',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  '78 BPM',
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ),
                              Container(
                                height: _heightDevice * 0.1,
                                child: LineChart(
                                  LineChartData(
                                    borderData: FlBorderData(show: false),
                                    gridData: FlGridData(show: false),
                                    titlesData: FlTitlesData(show: false),
                                    lineTouchData: LineTouchData(
                                      enabled: true,
                                      touchTooltipData: LineTouchTooltipData(
                                        tooltipRoundedRadius: 20,
                                        tooltipBgColor: Colors.blue,
                                        getTooltipItems: (List<LineBarSpot>
                                            touchedBarSpots) {
                                          return touchedBarSpots.map((barSpot) {
                                            final flSpot = barSpot;
                                            return LineTooltipItem(
                                              '${flSpot.x.toInt()}mins ago',
                                              const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          }).toList();
                                        },
                                      ),
                                    ),
                                    minX: 1,
                                    maxX: 30,
                                    minY: 80,
                                    maxY: 170,
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: const [
                                          FlSpot(1, 100),
                                          FlSpot(2, 130),
                                          FlSpot(3, 90),
                                          FlSpot(4, 150),
                                          FlSpot(5, 110),
                                          FlSpot(6, 120),
                                          FlSpot(7, 100),
                                          FlSpot(8, 120),
                                          FlSpot(9, 125),
                                          FlSpot(10, 100),
                                          FlSpot(11, 90),
                                          FlSpot(12, 150),
                                          FlSpot(13, 85),
                                          FlSpot(14, 100),
                                          FlSpot(15, 80),
                                          FlSpot(16, 100),
                                          FlSpot(17, 130),
                                          FlSpot(18, 90),
                                          FlSpot(19, 150),
                                          FlSpot(20, 110),
                                          FlSpot(21, 120),
                                          FlSpot(22, 100),
                                          FlSpot(23, 120),
                                          FlSpot(24, 125),
                                          FlSpot(25, 100),
                                          FlSpot(26, 90),
                                          FlSpot(27, 150),
                                          FlSpot(28, 85),
                                          FlSpot(29, 100),
                                          FlSpot(30, 120),
                                        ],
                                        barWidth: 3,
                                        dotData: FlDotData(show: false),
                                        belowBarData: BarAreaData(show: false),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.blue[200]!,
                                            Colors.blue[400]!,
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: _heightDevice * 0.4,
                                width: _widthDevice * 0.45,
                                padding: const EdgeInsets.only(left: 5, top: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 2.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(0.5, 0.5),
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Water Intake',
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                    const SizedBox(height: 7),
                                    Text(
                                      '10 Liters',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                    const SizedBox(height: 7),
                                    const Text(
                                      'Real time updates',
                                      style: TextStyle(
                                        fontFamily: 'Sen',
                                        fontSize: 15,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Divider(),
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Container(
                                          child: Column(
                                            children: timeProgress.map((e) {
                                              return Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 20),
                                                        height: 15,
                                                        width: 15,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          gradient:
                                                              LinearGradient(
                                                            colors: [
                                                              Colors
                                                                  .purple[100]!,
                                                              const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  209,
                                                                  159,
                                                                  218),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        e,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline1,
                                                      ),
                                                    ],
                                                  ),
                                                  if (litersProgress[e] != null)
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 6,
                                                                  top: 1),
                                                          child: DottedLine(
                                                            lineThickness: 1.5,
                                                            lineLength: 50,
                                                            direction:
                                                                Axis.vertical,
                                                            dashLength: 4.5,
                                                            dashGradient: [
                                                              Colors
                                                                  .purple[100]!,
                                                              const Color
                                                                  .fromARGB(
                                                                255,
                                                                209,
                                                                159,
                                                                218,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 25),
                                                        Text(
                                                          litersProgress[e]
                                                              as String,
                                                          style: TextStyle(
                                                            fontFamily: 'Sen',
                                                            fontSize: 23,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            foreground: Paint()
                                                              ..shader =
                                                                  LinearGradient(
                                                                      colors: [
                                                                    Colors.purple[
                                                                        100]!,
                                                                    Colors.purple[
                                                                        200]!,
                                                                    Colors.purple[
                                                                        300]!,
                                                                  ]).createShader(
                                                                const Rect
                                                                        .fromLTWH(
                                                                    0.0,
                                                                    0.0,
                                                                    200.0,
                                                                    70.0),
                                                              ),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: _heightDevice * 0.4,
                                width: _widthDevice * 0.45,
                                padding: const EdgeInsets.only(left: 5, top: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 2.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(0.5, 0.5),
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sleep',
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                    const SizedBox(height: 7),
                                    Text(
                                      '5h 10m',
                                      style:
                                          Theme.of(context).textTheme.headline2,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

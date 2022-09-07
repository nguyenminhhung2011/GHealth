import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../template/misc/colors.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget(
      {Key? key, required this.listData, required this.dateTime})
      : super(key: key);
  final List<int> listData;
  final List<DateTime> dateTime;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 4,
        minY: 0,
        maxY: 2,
        titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              axisNameWidget: Row(
                children: const [
                  Text(
                    '25/7/2022',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '1/8/2022',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            leftTitles: AxisTitles(
              //drawBehindEverything: false,
              axisNameWidget: Row(
                children: const [
                  Spacer(),
                  Text(
                    '35',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '70',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            topTitles: AxisTitles(
              axisNameWidget: Container(),
            ),
            rightTitles: AxisTitles(
              axisNameWidget: Container(),
            )),
        gridData: FlGridData(
          show: true,
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: const Color(0xff37434d),
            width: 1,
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 0),
              FlSpot(1, 1),
              FlSpot(2, 1),
              FlSpot(3, 2),
              FlSpot(4, 1.5),
            ],
            //dotData: FlDotData(show:),
            gradient: AppColors.colorGradient,
            barWidth: 2,
            belowBarData: BarAreaData(
              show: true,
              gradient: AppColors.colorOfBarChar,
            ),
          )
        ],
      ),
    );
  }
}

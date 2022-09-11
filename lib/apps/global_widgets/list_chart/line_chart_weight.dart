import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../template/misc/colors.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget(
      {Key? key,
      required this.listData,
      required this.dateTime,
      required this.maxData})
      : super(key: key);
  final List<int> listData;
  final List<DateTime> dateTime;
  final int maxData;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      swapAnimationDuration: const Duration(milliseconds: 250),
      LineChartData(
        minX: 0,
        maxX: listData.length - 1,
        minY: 0,
        maxY: 2,
        titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              axisNameWidget: Row(
                children: [
                  Text(
                    DateFormat().add_yMd().format(dateTime[0]),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    DateFormat()
                        .add_yMd()
                        .format(dateTime[dateTime.length - 1]),
                    style: const TextStyle(
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
                children: [
                  const Spacer(),
                  Text(
                    (maxData / 2).round().toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    maxData.toString(),
                    style: const TextStyle(
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
            spots: [
              for (int i = 0; i < listData.length; i++)
                FlSpot(
                    i * 1.0, (maxData != 0) ? (listData[i] / maxData) * 2 : 0),
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

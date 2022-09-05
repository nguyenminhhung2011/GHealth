import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../template/misc/colors.dart';

class LineChartSleep extends StatelessWidget {
  const LineChartSleep({Key? key, required this.data, required this.columnData})
      : super(key: key);
  final List<FlSpot> data;
  final int columnData;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      swapAnimationDuration: const Duration(milliseconds: 250),
      LineChartData(
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
            show: false,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.black,
                strokeWidth: 0.4,
              );
            },
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: Colors.black,
                strokeWidth: 0,
              );
            }),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
                reservedSize: 32,
                interval: 1,
                showTitles: true,
                getTitlesWidget: rightTitleWidget),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              interval: 1,
              getTitlesWidget: bottomTitleWidgets,
            ),
          ),
        ),
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipRoundedRadius: 20,
            tooltipBgColor: Colors.white,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                return LineTooltipItem(
                  '43% increase',
                  const TextStyle(
                    color: Colors.green,
                  ),
                );
              }).toList();
            },
          ),
        ),
        minX: 1,
        maxX: 7,
        minY: 0,
        maxY: 2,
        lineBarsData: [
          LineChartBarData(
            spots: data,
            barWidth: 2,
            dotData: FlDotData(show: false),
            gradient: AppColors.colorGradient,
            isCurved: true,
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  const Color.fromARGB(255, 187, 216, 239).withOpacity(0.08),
                  const Color.fromARGB(255, 187, 216, 239).withOpacity(0.1),
                  const Color.fromARGB(255, 187, 216, 239).withOpacity(0.2),
                  const Color.fromARGB(255, 187, 216, 239).withOpacity(0.4),
                  const Color.fromARGB(255, 187, 216, 239).withOpacity(0.5),
                  const Color.fromARGB(255, 187, 216, 239).withOpacity(0.7),
                  const Color.fromARGB(255, 187, 216, 239).withOpacity(0.8),
                  const Color.fromARGB(255, 187, 216, 239).withOpacity(0.9),
                  const Color.fromARGB(255, 187, 216, 239).withOpacity(1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('Sun', style: style);
        break;
      case 2:
        text = const Text('Mon', style: style);
        break;
      case 3:
        text = const Text('Tue', style: style);
        break;
      case 4:
        text = const Text('Wed', style: style);
        break;
      case 5:
        text = const Text('Thu', style: style);
        break;
      case 6:
        text = const Text('Fri', style: style);
        break;
      case 7:
        text = const Text('Sat', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  Widget rightTitleWidget(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('0h', style: style);
        break;
      case 1:
        text = Text('${(columnData / 2).round()}h', style: style);
        break;
      case 2:
        text = Text('${columnData}h', style: style);
        break;

      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }
}

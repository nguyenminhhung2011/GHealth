import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../template/misc/colors.dart';

class LineChartSleep extends StatelessWidget {
  const LineChartSleep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
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
        maxY: 8,
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(1, 3),
              FlSpot(2, 4),
              FlSpot(3, 5),
              FlSpot(4, 3),
              FlSpot(5, 3),
              FlSpot(6, 4.5),
              FlSpot(7, 5.5),
            ],
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
}

int touchedIndex = -1;

List<PieChartSectionData> showingSections(var widthDevice) {
  return List.generate(4, (i) {
    final isTouched = i == touchedIndex;
    final fontSize = isTouched ? 25.0 : 16.0;
    final radius = isTouched
        ? (widthDevice as double) * 0.18
        : (widthDevice as double) * 0.15;
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: Colors.blue[300],
          value: 40,
          title: '40%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        );
      case 1:
        return PieChartSectionData(
          color: Colors.amber[300],
          value: 30,
          title: '30%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 2:
        return PieChartSectionData(
          color: const Color.fromARGB(255, 108, 39, 176).withOpacity(0.6),
          value: 15,
          title: '15%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 3:
        return PieChartSectionData(
          color: Colors.green[300],
          value: 15,
          title: '15%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      default:
        throw Error();
    }
  });
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
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
      text = const Text('1h', style: style);
      break;
    case 2:
      text = const Text('2h', style: style);
      break;
    case 3:
      text = const Text('3h', style: style);
      break;
    case 4:
      text = const Text('4h', style: style);
      break;
    case 5:
      text = const Text('5h', style: style);
      break;
    case 6:
      text = const Text('6h', style: style);
      break;
    case 7:
      text = const Text('7h', style: style);
      break;
    case 8:
      text = const Text('8h', style: style);
      break;
    case 9:
      text = const Text('9h', style: style);
      break;
    case 10:
      text = const Text('10h', style: style);
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

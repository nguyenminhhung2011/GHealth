import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../template/misc/colors.dart';

class LineChartOneLine extends StatelessWidget {
  LineChartOneLine({
    Key? key,
    required this.listData,
    required this.callBack,
  }) : super(key: key);
  final List<FlSpot> listData;
  final Function(FlTouchEvent, LineTouchResponse?) callBack;
  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData1,
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 1,
        maxX: 7,
        maxY: 6,
        minY: 1,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.black,
        ),
        touchCallback: callBack,
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
      ];

  List<LineChartBarData> get lineBarsData2 => [];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '0%';
        break;
      case 2:
        text = '20%';
        break;
      case 3:
        text = '40%';
        break;
      case 4:
        text = '60%';
        break;
      case 5:
        text = '80%';
        break;
      case 6:
        text = '100%';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
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
      case 1:
        text = const Text('Sun', style: style);
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

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );
  FlGridData get gridData => FlGridData(
      show: true,
      drawVerticalLine: true,
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
      });

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
      isCurved: true,
      color: AppColors.primaryColor1,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
      ),
      belowBarData: BarAreaData(show: false),
      spots: listData);
}

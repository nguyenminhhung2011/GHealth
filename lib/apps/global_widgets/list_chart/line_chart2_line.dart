import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../template/misc/colors.dart';

// ignore: must_be_immutable
class LineChartTwoLine extends StatefulWidget {
  const LineChartTwoLine({Key? key}) : super(key: key);

  @override
  State<LineChartTwoLine> createState() => _LineChartTwoLineState();
}

class _LineChartTwoLineState extends State<LineChartTwoLine> {
  RxList<FlSpot> list1FlSpot = [
    const FlSpot(1, 100),
    const FlSpot(2, 100),
    const FlSpot(3, 100),
    const FlSpot(4, 100),
    const FlSpot(5, 100),
    const FlSpot(6, 100),
    const FlSpot(7, 100),
  ].obs;

  RxList<FlSpot> list2FlSpot = [const FlSpot(0, 0)].obs;

  List<FlSpot> list1 = const [
    FlSpot(1, 150),
    FlSpot(2, 500),
    FlSpot(3, 130),
    FlSpot(4, 500),
    FlSpot(5, 600),
    FlSpot(6, 550),
    FlSpot(7, 700),
  ];

  List<FlSpot> list2 = const [
    FlSpot(1, 500),
    FlSpot(2, 410),
    FlSpot(3, 450),
    FlSpot(4, 320),
    FlSpot(5, 250),
    FlSpot(6, 110),
    FlSpot(7, 150),
  ];

  void _addDataToRxList() async {
    list1FlSpot.value = list1;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    await Future.delayed(const Duration(seconds: 1), _addDataToRxList);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => LineChart(
          sampleData1,
          swapAnimationCurve: Curves.linear,
          swapAnimationDuration: const Duration(milliseconds: 400),
        ));
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 1,
        maxX: 7,
        maxY: 1100,
        minY: 100,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
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
      case 100:
        text = '100';
        break;
      case 300:
        text = '300';
        break;
      case 500:
        text = '500';
        break;
      case 700:
        text = '700';
        break;
      case 900:
        text = '900';
        break;
      case 1100:
        text = '1100';
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
        spots: list1FlSpot.value,
      );

  LineChartBarData get lineChartBarData1_2 => (LineChartBarData(
        isCurved: true,
        color: AppColors.primaryColor2.withOpacity(0.5),
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
        ),
        belowBarData: BarAreaData(show: false),
        spots: list2FlSpot.value,
      ));
}

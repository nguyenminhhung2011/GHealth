import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../template/misc/colors.dart';

class LineHeartChart extends StatelessWidget {
  const LineHeartChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipRoundedRadius: 20,
            tooltipBgColor: AppColors.primaryColor1,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
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
            barWidth: 2,
            dotData: FlDotData(show: false),
            gradient: AppColors.colorGradient,
            belowBarData: BarAreaData(
              show: true,
              gradient: AppColors.colorContainerTodayTarget,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GraficoLinear extends StatelessWidget {
  final List<FlSpot> chartData = [
    const FlSpot(0, 2),
    const FlSpot(1, 5),
    const FlSpot(2, 4),
    const FlSpot(3, 7),
    const FlSpot(4, 6),
    const FlSpot(5, 10),
    const FlSpot(6, 9),
  ];
  GraficoLinear({super.key});
  @override
  LineChart build(BuildContext context) {
    return LineChart(LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: chartData,
          isCurved: true,
          dotData: const FlDotData(
            show: false,
          ),
          color: Colors.blue,
          barWidth: 3,
        ),
      ],
      borderData: FlBorderData(
          border: const Border(bottom: BorderSide(), left: BorderSide())),
      gridData: const FlGridData(show: false),
      titlesData: const FlTitlesData(
        leftTitles: AxisTitles(
            axisNameSize: 5,
            sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 12,
    ));
  }
}

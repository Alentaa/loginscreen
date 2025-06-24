import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LeaveBarChart extends StatelessWidget {
  const LeaveBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
        barTouchData: BarTouchData(enabled: false),
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(),
          topTitles: AxisTitles(),
          rightTitles: AxisTitles(),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                const titles = ['Q1', 'Q2', 'Q3', 'Q4'];
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(titles[value.toInt()], style: const TextStyle(fontSize: 14)),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: [
          _makeBarData(0, 6),
          _makeBarData(1, 4),
          _makeBarData(2, 3),
          _makeBarData(3, 2),
        ],
      ),
    );
  }

  BarChartGroupData _makeBarData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: const Color.fromARGB(255, 23, 144, 242),
          width: 70,
          borderRadius: BorderRadius.circular(2),
        ),
      ],
    );
  }
}

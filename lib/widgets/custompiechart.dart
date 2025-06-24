import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/attendance_viewmodel.dart';

class CustomPieChartWidget extends StatelessWidget {
  const CustomPieChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AttendanceViewModel>(context);

    final List<PieChartSectionData> sections = [
      _buildSection(vm.presentCount, 'Present', Colors.green),
      _buildSection(vm.absentCount, 'Absent', Colors.red),
      _buildSection(vm.leaveCount, 'Leaves', Colors.orange),
      _buildSection(vm.lateCount, 'Late', Colors.blue),
    ];

    return AspectRatio(
      aspectRatio: 1.3,
      child: PieChart(
        PieChartData(
          sections: sections,
          centerSpaceRadius: 70,
          sectionsSpace: 1,
          startDegreeOffset: 0,
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }

  PieChartSectionData _buildSection(int count, String label, Color color) {
    return PieChartSectionData(
      color: color,
      value: count.toDouble(),
      title: '${count.toString().padLeft(2, '0')} \nDays',
      titleStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titlePositionPercentageOffset: 0.6,
      radius: 70,
    );
  }
}

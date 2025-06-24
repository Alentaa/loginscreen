import 'package:flutter/material.dart';
import 'package:loginscreen/widgets/custompiechart.dart';


class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Attendance Overview")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: const CustomPieChartWidget(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:loginscreen/widgets/attendance_calender.dart';
import 'package:loginscreen/widgets/custompiechart.dart';
import 'package:loginscreen/widgets/day_details.dart';
import 'package:loginscreen/widgets/overview_section.dart';
import 'package:loginscreen/widgets/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../viewmodel/attendance_viewmodel.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AttendanceViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Attendance Calendar'),
          centerTitle: true,
          leading: const BackButton(),
        ),
        body: Padding(
          padding: EdgeInsets.all(3.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const AttendanceCalendar(),
                SizedBox(height: 2.h),
                const OverviewSection(),
                SizedBox(height: 2.h),
                const CustomPieChartWidget(),
                SizedBox(height: 2.h),
                const DayDetailsCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

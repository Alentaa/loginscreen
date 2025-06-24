import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../viewmodel/attendance_viewmodel.dart';

class OverviewSection extends StatelessWidget {
  const OverviewSection({super.key});

  Widget buildCard(String title, String value, Color color) {
    return Container(
      width: 20.w,
      padding: EdgeInsets.symmetric(vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
              color: color,
            ),
          ),
          SizedBox(height: 1.h),
          Text(title, style: TextStyle(fontSize: 16.sp)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AttendanceViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Overview\nTotal Days : ${vm.totalDays}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
          ),
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildCard("Presence", vm.presentCount.toString().padLeft(2, '0'), Colors.green),
            buildCard("Absence", vm.absentCount.toString().padLeft(2, '0'), Colors.red),
            buildCard("Leaves", vm.leaveCount.toString().padLeft(2, '0'), Colors.orange),
            buildCard("Late", vm.lateCount.toString().padLeft(2, '0'), Colors.blue),
          ],
        ),
      ],
    );
  }
}

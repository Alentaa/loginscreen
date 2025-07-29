import 'package:flutter/material.dart';
import 'package:loginscreen/constants/app_colors.dart';
import 'package:loginscreen/view/view/attendanceScreen.dart';
import 'package:loginscreen/view/view/dashboard.dart';
import 'package:loginscreen/view/view/holidayScreen.dart';
import 'package:loginscreen/view/view/leave_dashboard.dart';
import 'package:loginscreen/view/view/leavestatus.dart';
import 'package:loginscreen/view/view/payslipscreen.dart';
import 'package:loginscreen/view/view/reportScreen.dart';
import 'package:loginscreen/widgets/payslipwidget.dart';

class DashboardGrid extends StatelessWidget {
  const DashboardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Attendance', Icons.calendar_today_rounded, AppColors.lightgreen),
      ('Leaves', Icons.logout_rounded, AppColors.orange),
      ('Leave Status', Icons.pie_chart_outline_rounded, AppColors.lavender),
      ('Holiday List', Icons.checklist_rounded, AppColors.lightblue),
      ('Payslip', Icons.receipt_long_rounded, AppColors.lightgreen),
      ('Reports', Icons.show_chart_rounded, AppColors.lightred),
    ];

    return GridView.builder(
      itemCount: items.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (_, i) {
        final (label, icon, colour) = items[i];

        return InkWell(
          onTap: () {
            if (label == 'Leaves') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LeaveDashboardScreen()),
              );
            } else if (label == 'Attendance') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AttendanceScreen()),
              );
            } else if (label == 'Holiday List') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HolidayScreen()),
              );
            } else if (label == 'Leave Status') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Leavestatus()),
              );
            } else if (label == 'Payslip') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PayslipScreen(month: 'June 2025'),
                ),
              );
            } else if (label == 'Reports') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ReportsScreen()),
              );
            }
          },
          child: DashCard(label: label, icon: icon, colour: colour),
        );
      },
    );
  }
}

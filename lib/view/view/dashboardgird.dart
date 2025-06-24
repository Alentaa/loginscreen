import 'package:flutter/material.dart';
import 'package:loginscreen/view/view/attendanceScreen.dart';
import 'package:loginscreen/view/view/dashboard.dart';
import 'package:loginscreen/view/view/leave_dashboard.dart';


class DashboardGrid extends StatelessWidget {
  const DashboardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Attendance', Icons.calendar_today_rounded, const Color(0xFF32C05E)),
      ('Leaves', Icons.logout_rounded, const Color(0xFFFF9D31)),
      (
        'Leave Status',
        Icons.pie_chart_outline_rounded,
        const Color(0xFFB063FF),
      ),
      ('Holiday List', Icons.checklist_rounded, const Color(0xFF3267FF)),
      ('Payslip', Icons.receipt_long_rounded, const Color(0xFF10B981)),
      ('Reports', Icons.show_chart_rounded, const Color(0xFFFF5E5E)),
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
            }
          },
          child: DashCard(label: label, icon: icon, colour: colour),
        );
      },
    );
  }
}

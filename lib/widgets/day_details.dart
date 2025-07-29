import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../viewmodel/attendance_viewmodel.dart';

class DayDetailsCard extends StatelessWidget {
  final DateTime selectedDate;
  const DayDetailsCard({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AttendanceViewModel>(context);
    final record = vm.getRecordByDate(selectedDate);
    final dateStr = DateFormat.yMMMMd().format(selectedDate);

    if (record == null) {
      return Padding(
        padding: EdgeInsets.all(3.w),
        child: Text(
          'No attendance record found.',
          style: TextStyle(fontSize: 16.sp, color: Colors.red),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dateStr,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
        ),
        SizedBox(height: 0.5.h),

        // ✅ Show status only if it's "present"
        if (record.status.toLowerCase() == "present")
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
            decoration: BoxDecoration(
              color: _getStatusColor(record.status).withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _capitalize(record.status),
              style: TextStyle(
                color: _getStatusColor(record.status),
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
              ),
            ),
          ),

        SizedBox(height: 1.5.h),

        // Details Container
        Container(
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hardcoded Punch-in / Punch-out
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _checkStatus("Punch-in", "09:15 AM", Icons.alarm_on, Colors.green),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Colors.grey),
                  _checkStatus("Punch-out", "05:30 PM", Icons.alarm_off, Colors.green),
                ],
              ),

              SizedBox(height: 1.h),
              // Text(
              //   "Worked 8 hrs 15 mins",
              //   style: TextStyle(
              //     color: Colors.blueGrey,
              //     fontWeight: FontWeight.bold,
              //     fontSize: 15.sp,
              //   ),
              // ),
              // SizedBox(height: 2.h),

              // Work mode & verification
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoChip(
                    title: "Work Mode",
                    value: record.mode ?? "Offline",
                    textColor: Colors.blue,
                  ),
                  _infoChip(
                    title: "Verification",
                    value: record.verification ?? "Selfie",
                    textColor: Colors.orange,
                  ),
                ],
              ),
              SizedBox(height: 2.h),

              // Location
              Row(
                children: [
                  const Icon(Icons.location_pin, color: Colors.red),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Text(
                      "Location\n${record.location ?? '--'}",
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),

              // Notes
              Row(
                children: [
                  const Icon(Icons.note_alt_outlined, color: Colors.black),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Text(
                      "Notes\n${record.note ?? 'Worked on UI Bug fixing'}",
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _checkStatus(String label, String time, IconData icon, Color iconColor) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 20.sp),
            SizedBox(width: 1.w),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        SizedBox(height: 0.5.h),
        Text(
          time,
          style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _infoChip({
    required String title,
    required String value,
    required Color textColor,
  }) {
    return Container(
      width: 40.w,
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: textColor.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(color: Colors.grey[800])),
          SizedBox(height: 0.5.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
            decoration: BoxDecoration(
              color: textColor.withOpacity(0.1),
              border: Border.all(color: textColor),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              value,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "present":
        return Colors.green;
      case "absent":
        return Colors.red;
      case "late":
        return Colors.orange;
      case "leave":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _capitalize(String s) =>
      s.isEmpty ? "" : s[0].toUpperCase() + s.substring(1);
}

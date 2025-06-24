import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DayDetailsCard extends StatelessWidget {
  const DayDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "June 18, 2025 ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
            ),
            
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Present",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),

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
              // Check-in / Check-out
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _checkStatus("Check-in", "09:30 AM", Icons.alarm_on, Colors.green),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Colors.grey),
                  _checkStatus("Check-out", "06:00 PM", Icons.alarm_off, Colors.green),
                ],
              ),
              SizedBox(height: 2.h),

             
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoChip(title: "Work Mode", value: "Office", textColor: Colors.blue),
                  _infoChip(title: "Verification", value: "Selfie", textColor: Colors.orange),
                ],
              ),
              SizedBox(height: 2.h),

             
              Row(
                children: [
                  const Icon(Icons.location_pin, color: Colors.red),
                  SizedBox(width: 2.w),
                  const Expanded(
                    child: Text(
                      "Location\nLat: 13.05, Long: 80.24",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),

             
              Row(
                children: [
                  const Icon(Icons.note_alt_outlined, color: Colors.black),
                  SizedBox(width: 2.w),
                  const Expanded(
                    child: Text(
                      " Notes \n Worked On UI Bug Fixing",
                      style: TextStyle(fontWeight: FontWeight.w500),
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
            Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        SizedBox(height: 0.5.h),
        Text(
          time,
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
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
}

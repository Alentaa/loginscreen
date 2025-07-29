import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AttendanceRecord {
  final String date;
  final String? checkIn;
  final String? checkOut;
  final String totalHours;
  final String status;

  AttendanceRecord({
    required this.date,
    this.checkIn,
    this.checkOut,
    required this.totalHours,
    required this.status,
  });
}

class ReportsViewModel extends ChangeNotifier {
  final List<AttendanceRecord> attendanceRecords = [
    AttendanceRecord(
      date: "June 21",
      checkIn: "09:15 AM",
      checkOut: "05:45 PM",
      totalHours: "8.5 hrs",
      status: "Present",
    ),
    AttendanceRecord(
      date: "June 22",
      checkIn: null,
      checkOut: null,
      totalHours: "0 hrs",
      status: "Absent",
    ),
    AttendanceRecord(
      date: "June 23",
      checkIn: "09:30 AM",
      checkOut: "04:00 PM",
      totalHours: "6.5 hrs",
      status: "Half Day",
    ),
  ];



  List<FlSpot> presentSpots = [
    FlSpot(0, 7),
    FlSpot(1, 8),
    FlSpot(2, 6.5),
    FlSpot(3, 8),
    FlSpot(4, 7),
    FlSpot(5, 8.2),
    FlSpot(6, 8.5),
    FlSpot(7, 8.3),
    FlSpot(8, 8.7),
    FlSpot(9, 8),
    FlSpot(10, 9),
    FlSpot(11, 9),
  ];

  List<FlSpot> absentSpots = [
    FlSpot(0, 4),
    FlSpot(1, 3.5),
    FlSpot(2, 3),
    FlSpot(3, 4),
    FlSpot(4, 3.5),
    FlSpot(5, 2.5),
    FlSpot(6, 3),
    FlSpot(7, 3.5),
    FlSpot(8, 3),
    FlSpot(9, 3.7),
    FlSpot(10, 2),
    FlSpot(11, 2.5),
  ];

  List<FlSpot> avgHourSpots = [
    FlSpot(0, 6),
    FlSpot(1, 5.8),
    FlSpot(2, 5.5),
    FlSpot(3, 6),
    FlSpot(4, 5.5),
    FlSpot(5, 5.4),
    FlSpot(6, 5.8),
    FlSpot(7, 6),
    FlSpot(8, 6.2),
    FlSpot(9, 6.1),
    FlSpot(10, 6),
    FlSpot(11, 6.2),
  ];
}

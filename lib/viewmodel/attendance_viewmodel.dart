import 'package:flutter/material.dart';
import 'package:loginscreen/model/attendace_model.dart';

class AttendanceViewModel extends ChangeNotifier {
  final List<AttendanceModel> _records = [
    AttendanceModel(
      date: DateTime(2025, 6, 18),
      status: "present",
      mode: "Office",
      verification: "Selfie",
      location: "Lat: 13.05, Long: 80.24",
      note: "Worked On UI Bug Fixing",
    ),
    AttendanceModel(date: DateTime(2025, 6, 6), status: "late"),
    AttendanceModel(date: DateTime(2025, 6, 9), status: ""),
    AttendanceModel(date: DateTime(2025, 6, 10), status: "present"),
    AttendanceModel(date: DateTime(2025, 6, 16), status: "present"),
    AttendanceModel(date: DateTime(2025, 6, 17), status: "present"),
    AttendanceModel(date: DateTime(2025, 6, 24), status: "absent"),
    AttendanceModel(date: DateTime(2025, 6, 25), status: "leave"),
    AttendanceModel(date: DateTime(2025, 6, 1), status: "present"),
    AttendanceModel(date: DateTime(2025, 6, 2), status: "present"),
    AttendanceModel(date: DateTime(2025, 6, 3), status: "late"),
    AttendanceModel(date: DateTime(2025, 6, 4), status: "present"),
    AttendanceModel(date: DateTime(2025, 6, 5), status: "present"),
    AttendanceModel(date: DateTime(2025, 6, 7), status: "present"),
    AttendanceModel(date: DateTime(2025, 6, 8), status: "present"),
    AttendanceModel(date: DateTime(2025, 6, 11), status: "late"),
    AttendanceModel(date: DateTime(2025, 6, 12), status: "present"),
    AttendanceModel(date: DateTime(2025, 6, 13), status: "leave"),
    AttendanceModel(date: DateTime(2025, 6, 14), status: "present"),
    AttendanceModel(date: DateTime(2025, 6, 15), status: "present"),
    AttendanceModel(date: DateTime(2025, 6, 19), status: "absent"),
    AttendanceModel(date: DateTime(2025, 6, 20), status: "present"),
    AttendanceModel(date: DateTime(2025, 6, 21), status: "present"),
    AttendanceModel(date: DateTime(2025, 6, 22), status: "present"),
    AttendanceModel(date: DateTime(2025, 6, 23), status: "late"),
    AttendanceModel(date: DateTime(2025, 6, 26), status: "present"),
    AttendanceModel(date: DateTime(2025, 6, 27), status: "late"),
    AttendanceModel(date: DateTime(2025, 6, 28), status: "present"),
    AttendanceModel(date: DateTime(2025, 6, 29), status: "present"),
    AttendanceModel(date: DateTime(2025, 6, 30), status: "present"),
  ];

  List<AttendanceModel> get records => _records;

  int get presentCount => _records.where((e) => e.status == "present").length;
  int get absentCount => _records.where((e) => e.status == "absent").length;
  int get leaveCount => _records.where((e) => e.status == "leave").length;
  int get lateCount => _records.where((e) => e.status == "late").length;

  int get totalDays => _records.length;

  AttendanceModel? getRecordByDate(DateTime date) {
    return _records.firstWhere(
      (e) => e.date.year == date.year &&
             e.date.month == date.month &&
             e.date.day == date.day,
      orElse: () => AttendanceModel(
        date: date,
        status: "absent",
        mode: null,
        verification: null,
        location: null,
        note: null,
      ),
    );
  }
}

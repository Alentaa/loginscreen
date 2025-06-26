
import 'package:flutter/material.dart';

class HolidayModel {
  final String date;
  final String day;
  final String name;
  final String type;
  final String note;
  final Color color;

  HolidayModel({
    required this.date,
    required this.day,
    required this.name,
    required this.type,
    required this.note,
    required this.color,
  });
    static HolidayModel empty() {
    return HolidayModel(
      date: '',
      day: '',
      name: '',
      type: '',
      note: '',
      color: Colors.transparent,
    );
  }
}


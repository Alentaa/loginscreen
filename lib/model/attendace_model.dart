class AttendanceModel {
  final DateTime date;
  final String status; 
  final String? mode;
  final String? verification;
  final String? location;
  final String? note;

  AttendanceModel({
    required this.date,
    required this.status,
    this.mode,
    this.verification,
    this.location,
    this.note,
  });
}

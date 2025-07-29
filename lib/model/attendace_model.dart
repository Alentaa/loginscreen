class AttendanceModel {
  final DateTime date;
  final String status;
  final String? mode;
  final String? verification;
  final String? location;
  final String? note;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;

  AttendanceModel({
    required this.date,
    required this.status,
    this.mode,
    this.verification,
    this.location,
    this.note,
    this.checkInTime,
    this.checkOutTime,
  });
}

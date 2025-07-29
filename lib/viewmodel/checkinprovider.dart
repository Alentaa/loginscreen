import 'package:flutter/material.dart';
import 'package:loginscreen/viewmodel/attendance_viewmodel.dart';
import 'package:provider/provider.dart';

class CheckinProvider with ChangeNotifier {
  bool isPunchedIn = false;
  DateTime? punchInTime;
  String? punchInMode; 
  String punchInLocation = "Nilambur, IP: 192.168.1.1";

  
  void setPunchInMode(String mode) {
    punchInMode = mode;
    notifyListeners();
  }

 
  String? getPunchInMode() => punchInMode;

  
  String? get location => punchInLocation;

  void punchIn(BuildContext context) {
    isPunchedIn = true;
    punchInTime = DateTime.now();

        final attendanceVM = Provider.of<AttendanceViewModel>(context, listen: false);
  attendanceVM.punchIn(DateTime.now(), punchInTime!);

    notifyListeners();
  }

  void punchOut(BuildContext context) {
    isPunchedIn = false;

      final punchOutTime = DateTime.now();
  final attendanceVM = Provider.of<AttendanceViewModel>(context, listen: false);
  attendanceVM.punchOut(DateTime.now(), punchOutTime);


    punchInTime = null;
    punchInMode = null;
    notifyListeners();
  }
}

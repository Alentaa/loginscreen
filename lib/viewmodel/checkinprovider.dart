import 'package:flutter/material.dart';

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

  void punchIn() {
    isPunchedIn = true;
    punchInTime = DateTime.now();
    notifyListeners();
  }

  void punchOut() {
    isPunchedIn = false;
    punchInTime = null;
    punchInMode = null;
    notifyListeners();
  }
}

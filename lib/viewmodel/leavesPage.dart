import 'package:flutter/material.dart';
import 'package:loginscreen/model/leavesPage_model.dart';

class LeaveFormViewModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController reasonController = TextEditingController();

  DateTime? fromDate;
  DateTime? toDate;
  String? leaveType;
  String? dayType;

  final List<String> leaveTypes = ['Casual', 'Sick', 'Annual'];
  final List<String> dayTypes = ['Full Day', 'Half Day'];

  String? dateError; 

 
  Future<void> pickDate(BuildContext context, bool isFrom) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
    );

    if (picked != null) {
      if (isFrom) {
        fromDate = picked;
        if (toDate != null && toDate!.isBefore(fromDate!)) {
          toDate = null;
        }
      } else {
        toDate = picked;
      }
      validateDates(); 
      notifyListeners();
    }
  }


  void updateLeaveType(String? value) {
    leaveType = value;
    notifyListeners();
  }

  void updateDayType(String? value) {
    dayType = value;
    notifyListeners();
  }


  void validateDates() {
    if (fromDate == null || toDate == null) {
      dateError = "Both dates are required";
    } else if (toDate!.isBefore(fromDate!)) {
      dateError = "To Date must be after From Date";
    } else {
      dateError = null;
    }
  }


  bool validateForm() {
    final formValid = formKey.currentState?.validate() ?? false;
    validateDates();

    final isValid =
        formValid &&
        fromDate != null &&
        toDate != null &&
        leaveType != null &&
        dayType != null &&
        dateError == null;

    notifyListeners();
    return isValid;
  }


  leaved createLeaveModel() {
    return leaved(
      employeeName: 'Employee Name - auto-filled',
      employeeId: 'Employee ID - auto-filled',
      fromDate: fromDate!,
      toDate: toDate!,
      leaveType: leaveType!,
      dayType: dayType!,
      reason: reasonController.text.trim(),
    );
  }
}

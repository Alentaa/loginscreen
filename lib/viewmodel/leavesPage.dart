import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:loginscreen/model/leavesPage_model.dart';

class LeaveFormViewModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController reasonController = TextEditingController();

  DateTime? fromDate;
  DateTime? toDate;
  String? leaveType;
  String? dayType;
  String? dateError;

  String? attachmentFileName;
  String? attachmentPath;

  final List<String> leaveTypes = ['Casual', 'Sick', 'Annual'];
  final List<String> dayTypes = ['Full Day', 'Half Day'];

  ///  Pick Date with proper constraints
  Future<void> pickDate(BuildContext context, bool isFrom) async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: isFrom
          ? (fromDate ?? now)
          : (toDate ?? fromDate ?? now),
      firstDate: now,
      lastDate: DateTime(2026),
      selectableDayPredicate: (date) {
        if (date.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
          return false;
        }

        if (!isFrom && fromDate != null) {
          return !date.isBefore(fromDate!);
        }

        return true;
      },
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

  ///  Dropdown Updates
  void updateLeaveType(String? value) {
    leaveType = value;
    notifyListeners();
  }

  void updateDayType(String? value) {
    dayType = value;
    notifyListeners();
  }

  ///  Date Validation
  void validateDates() {
    if (fromDate == null || toDate == null) {
      dateError = "Both dates are required";
    } else if (toDate!.isBefore(fromDate!)) {
      dateError = "To Date must be after From Date";
    } else {
      dateError = null;
    }
  }

  ///  File Picker for attachment
  Future<void> pickAttachment() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      attachmentFileName = result.files.single.name;
      attachmentPath = result.files.single.path;
      notifyListeners();
    }
  }

  ///  Final Form Validation
  bool validateForm() {
    final formValid = formKey.currentState?.validate() ?? false;
    validateDates();

    final isValid = formValid &&
        fromDate != null &&
        toDate != null &&
        leaveType != null &&
        dayType != null &&
        dateError == null;

    notifyListeners();
    return isValid;
  }

  ///  Create leave model
  leaved createLeaveModel() {
    return leaved(
      employeeName: 'Employee Name - auto-filled',
      employeeId: 'Employee ID - auto-filled',
      fromDate: fromDate!,
      toDate: toDate!,
      leaveType: leaveType!,
      dayType: dayType!,
      reason: reasonController.text.trim(),
      attachmentPath: attachmentPath,
    );
  }
}

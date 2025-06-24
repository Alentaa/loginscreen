import 'package:flutter/material.dart';
import 'package:loginscreen/model/leave_model.dart';


class LeaveDashboardViewModel extends ChangeNotifier {
  int selectedTabIndex = 0;
  final TextEditingController searchController = TextEditingController();
  bool showSuggestions = false;

  final List<String> allSuggestions = [
    'Medical Leave',
    'Vacation',
    'Work From Home',
    'Emergency Leave',
    'Pending Request',
    'Approved',
  ];

  final List<LeaveData> leaveCards = [
    LeaveData(
      title: 'Total Leave Taken',
      value: '16 days',
      subtitle: '29 days remaining this year',
      icon: Icons.sticky_note_2_outlined,
    ),
    LeaveData(
      title: 'Approval Rate',
      value: '92%',
      subtitle: '29 days remaining this year',
      icon: Icons.verified_user_outlined,
    ),
    LeaveData(
      title: 'Pending Request',
      value: '1',
      subtitle: '29 days remaining this year',
      icon: Icons.hourglass_empty_outlined,
    ),
    LeaveData(
      title: 'Team Member on Leave',
      value: '2',
      subtitle: '29 days remaining this year',
      icon: Icons.group_outlined,
    ),
  ];

  void changeTab(int index) {
    selectedTabIndex = index;
    notifyListeners();
  }

  void onSearchChanged(String value) {
    showSuggestions = value.isNotEmpty;
    notifyListeners();
  }

  void onSuggestionTap(String suggestion) {
    searchController.text = suggestion;
    showSuggestions = false;
    notifyListeners();
  }
}

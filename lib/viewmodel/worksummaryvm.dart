import 'package:flutter/material.dart';
import 'package:loginscreen/model/worksummarymodel.dart';


class WorkSummaryViewModel extends ChangeNotifier {
  List<WorkSummaryModel> _summaryItems = [];

  List<WorkSummaryModel> get summaryItems => _summaryItems;

  WorkSummaryViewModel() {
    _loadData(); 
  }

  void _loadData() {
    _summaryItems = [
      WorkSummaryModel(
        title: "Total Working Days",
        value: "20",
        icon: Icons.calendar_today,
      ),
      WorkSummaryModel(
        title: "Total Hours Worked",
        value: "160 hours",
        icon: Icons.access_time,
      ),
      WorkSummaryModel(
        title: "Average Daily Hours",
        value: "8.0 hours",
        icon: Icons.av_timer,
      ),
      WorkSummaryModel(
        title: "Productivity Indicator",
        value: "80%",
        icon: Icons.bar_chart,
      ),
      WorkSummaryModel(
        title: "Projects Involved",
        value: "Revenue Dashboard",
        icon: Icons.work_outline,
      ),
      WorkSummaryModel(
        title: "Leave Taken",
        value: "2 days",
        icon: Icons.event_note,
      ),
    ];
    notifyListeners();
  }
}

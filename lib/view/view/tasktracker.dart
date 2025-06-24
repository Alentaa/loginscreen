import 'package:flutter/material.dart';
import 'package:loginscreen/view/view/tasktrackercard.dart';

class TaskTrackerTab extends StatelessWidget {
  const TaskTrackerTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TaskTrackerCard(
            title: "Responsive Design",
            progress: 0.45,
            status: "In Progress",
            deadline: "18-06-2025",
            daysRemaining: 2,
            priority: "Medium",
            selectedAction: "Update",
          ),
          const SizedBox(height: 20),
          const TaskTrackerCard(
            title: "UI/UX Design Implementation",
            progress: 0.69,
            status: "Completed",
            deadline: "18-06-2025",
            daysRemaining: 2,
            priority: "High",
            selectedAction: "Complete",
          ),
          const SizedBox(height: 20),
          const TaskTrackerCard(
            title: "Back-end Development",
            progress: 0.75,
            status: "In Progress",
            deadline: "18-06-2025",
            daysRemaining: 2,
            priority: "Low",
            selectedAction: "Start",
          ),
        ],
      ),
    );
  }
}

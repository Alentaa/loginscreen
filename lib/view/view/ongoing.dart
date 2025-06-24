import 'package:flutter/material.dart';

class OngoingPendingTab extends StatelessWidget {
  const OngoingPendingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: const [
          TaskCard(
            title: "UI/UX Design Implementation",
            status: "Ongoing Task",
            statusColor: Colors.blue,
            priority: "High",
            priorityColor: Colors.red,
            progress: 0.6,
            actionText: "Make as Done",
          ),
          SizedBox(height: 16),
          TaskCard(
            title: "Responsive Design",
            status: "Pending Task",
            statusColor: Colors.orange,
            priority: "Medium",
            priorityColor: Colors.orange,
            progress: 0.45,
            actionText: "Start Task",
          ),
          SizedBox(height: 16),
          TaskCard(
            title: "Back-end Development",
            status: "Ongoing Task",
            statusColor: Colors.blue,
            priority: "High",
            priorityColor: Colors.red,
            progress: 0.75,
            actionText: "In Progress",
          ),
        ],
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final String status;
  final Color statusColor;
  final String priority;
  final Color priorityColor;
  final double progress;
  final String actionText;

  const TaskCard({
    super.key,
    required this.title,
    required this.status,
    required this.statusColor,
    required this.priority,
    required this.priorityColor,
    required this.progress,
    required this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                "${(progress * 100).round()}% Done",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          
          Row(
            children: [
              const Text(
                "Status: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                status,
                style: TextStyle(color: statusColor),
              ),
            ],
          ),

          const SizedBox(height: 4),
          const Text("Assigned date: 12-05-2025"),
          const Text("Due date: 12-06-2025"),

          const SizedBox(height: 4),

        
          Row(
            children: [
              const Text(
                "Priority: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                priority,
                style: TextStyle(color: priorityColor),
              ),
            ],
          ),

          const SizedBox(height: 12),

      
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.grey[300],
              color: Colors.green,
            ),
          ),

          const SizedBox(height: 16),

          
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                actionText,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

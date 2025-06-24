import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class TaskMyTab extends StatelessWidget {
  const TaskMyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        TaskListItem(
          title: 'UI/UX Design Implementation',
          description:
              'Translating design specifications into functional and visually appealing user interfaces using technologies like HTML, CSS, and JavaScript.',
        ),
        SizedBox(height: 12),
        TaskListItem(
          title: 'Responsive Design',
          description:
              'Ensuring that the application adapts seamlessly to different screen sizes and devices.',
        ),
        SizedBox(height: 12),
        TaskListItem(
          title: 'Back-end Development',
          description:
              'Creating and managing databases for efficient data storage, retrieval, and processing.',
        ),
        SizedBox(height: 12),
        TaskListItem(
          title: 'Server- Side Logic',
          description:
              'Developing and Maintaining the Logic that runs on the server, handling user requests, processing data, and interacting with databases.',
        ),
      ],
    );
  }
}

class TaskListItem extends StatelessWidget {
  final String title;
  final String description;

  const TaskListItem({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isSmallScreen ? 14 : 15,
            fontWeight: FontWeight.w600,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          description,
          style: TextStyle(
            fontSize: isSmallScreen ? 12.5 : 13.5,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: screenWidth * 0.25,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10),
                backgroundColor: Color(0xFF008CFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Start", style: TextStyle(fontSize: 13)),
            ),
          ),
        ),

        const SizedBox(height: 8),
        DottedLine(
          dashColor: Colors.grey.shade400,
          lineThickness: 1.0,
          dashLength: 4.0,
          dashGapLength: 3.0,
        ),

        // const SizedBox(height: 8),
        // Divider(color: Colors.grey.shade400, thickness: 0.5,),
      ],
    );
  }
}

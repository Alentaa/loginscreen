import 'package:flutter/material.dart';
import 'package:loginscreen/view/view/mytasks.dart';

class TaskMyTab extends StatelessWidget {
  const TaskMyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TaskListItem(
          title: 'UI/UX Design Implementation',
          description:
              'Translating design specifications into functional and visually appealing user interfaces using technologies like HTML, CSS, and JavaScript.',
        ),
        SizedBox(height: 20),
        TaskListItem(
          title: 'Responsive Design',
          description:
              'Ensuring that the application adapts seamlessly to different screen sizes and devices.',
        ),
        SizedBox(height: 20),
        TaskListItem(
          title: 'Back-end Development',
          description:
              'Creating and managing databases for efficient data storage, retrieval, and processing.',
        ),
      ],
    );
  }
}

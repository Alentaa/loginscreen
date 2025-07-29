import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TaskTrackerCard extends StatelessWidget {
  final String title;
  final double progress;
  final String status; 
  final String deadline;
  final int daysRemaining;
  final String priority;
  final String selectedAction;

  const TaskTrackerCard({
    super.key,
    required this.title,
    required this.progress,
    required this.status, 
    required this.deadline,
    required this.daysRemaining,
    required this.priority,
    required this.selectedAction,
  });


  Widget _statusDot(Color color) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _priorityLabel(String label, String selected) {
    final isSelected = label == selected;
    final color =
        isSelected
            ? (label == "High"
                ? Colors.red
                : label == "Medium"
                ? Colors.orange
                : Colors.green)
            : Colors.grey;

    return Text(
      label,
      style: TextStyle(
        color: color,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _actionRadio(String value, String groupValue) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio(value: value, groupValue: groupValue, onChanged: (_) {}),
        Text(value, style: const TextStyle(fontSize: 10)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).toInt();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title & Deadline
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "Due Date: $deadline",
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Status Legend
              Wrap(
                spacing: 12,
                runSpacing: 4,
                children: [
                  _legend("Not Started", Colors.grey),
                  _legend("In Progress", Colors.amber),
                  _legend("Completed", Colors.green),
                  _legend("Overdue", Colors.red),
                ],
              ),
              const SizedBox(height: 12),

              // Progress and Days
              Row(
                children: [
                  CircularPercentIndicator(
                    radius: 20.0,
                    lineWidth: 5.0,
                    percent: progress,
                    center: Text(
                      "$percent%",
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    progressColor: Colors.green,
                    backgroundColor: Colors.grey.shade300,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$daysRemaining days remaining",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: const [
                            Icon(Icons.edit_note, size: 14),
                            SizedBox(width: 9),
                            Text(
                              "Assigned By (optional)",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Priority
              Row(
                children: [
                  const Text("Priority: ", style: TextStyle(fontSize: 13)),
                  const SizedBox(width: 4),
                  _priorityLabel("Low", priority),
                  const SizedBox(width: 10),
                  _priorityLabel("Medium", priority),
                  const SizedBox(width: 10),
                  _priorityLabel("High", priority),
                ],
              ),
              const SizedBox(height: 12),

              // Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,spacing: 13,
                children: [
                  _actionRadio("Start", selectedAction),
                  _actionRadio("Update", selectedAction),
                  _actionRadio("Complete", selectedAction),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _legend(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _statusDot(color),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

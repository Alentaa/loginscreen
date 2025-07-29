import 'package:flutter/material.dart';
import 'package:loginscreen/constants/app_colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('Notifications', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.grey),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNotificationTile(
            icon: Icons.close,
            color: Colors.red,
            title: 'Missed Punch',
            message: 'Missed Clock-in Detected. Please update your attendance or contact HR.',
          ),
          _buildNotificationTile(
            icon: Icons.access_time,
            color: Colors.orange,
            title: 'Late Attendance',
            message: 'You\'re running late! Your clock-in time is beyond the scheduled shift start.',
          ),
          _buildNotificationTile(
            icon: Icons.insert_chart,
            color: Colors.blue,
            title: 'Daily Summary',
            message: 'Clock-in at 9:12 AM, Clock-out at 6:05 PM. Total hours: 8.53',
          ),
          _buildNotificationTile(
            icon: Icons.check_circle,
            color: Colors.green,
            title: 'Leave Approval',
            message: 'Your leave request for June 15 has been approved. Enjoy your day off!',
          ),
          _buildNotificationTile(
            icon: Icons.cancel,
            color: Colors.red,
            title: 'Leave Rejection',
            message: 'Leave request declined. Please check with your manager for details.',
          ),
          _buildNotificationTile(
            icon: Icons.update,
            color: Colors.lightBlue,
            title: 'Shift Update',
            message: 'New shift time is 10:00 AM – 7:00 PM, effective from June 14.',
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationTile({
    required IconData icon,
    required Color color,
    required String title,
    required String message,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color,
                        fontSize: 16)),
                const SizedBox(height: 4),
                Text(message,
                    style: const TextStyle(fontSize: 13, color: AppColors.black)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

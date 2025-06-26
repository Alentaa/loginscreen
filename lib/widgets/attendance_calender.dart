import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceCalendar extends StatefulWidget {
  const AttendanceCalendar({super.key});

  @override
  State<AttendanceCalendar> createState() => _AttendanceCalendarState();
}

class _AttendanceCalendarState extends State<AttendanceCalendar> {
  final DateTime _focusedDay = DateTime.utc(2025, 6, 15);

  final Map<DateTime, String> eventDays = {
    DateTime.utc(2025, 6, 6): 'late',
    DateTime.utc(2025, 6, 9): 'present',
    DateTime.utc(2025, 6, 10): 'present',
    DateTime.utc(2025, 6, 16): 'present',
    DateTime.utc(2025, 6, 17): 'present',
    DateTime.utc(2025, 6, 24): 'absent',
    DateTime.utc(2025, 6, 25): 'leave',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Static Header (No navigation)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 254, 254),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text(
              "June 2025",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        // Calendar
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TableCalendar(
            firstDay: DateTime.utc(2025, 6, 1),
            lastDay: DateTime.utc(2025, 6, 30),
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            headerVisible: false,
            availableGestures: AvailableGestures.none, // Disable swiping
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekendStyle: TextStyle(color: Colors.red),
              weekdayStyle: TextStyle(color: Colors.blue),
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, _) {
                // Only show June dates
                if (day.month != 6) return const SizedBox.shrink();

                final type =
                    eventDays[DateTime.utc(day.year, day.month, day.day)];
                if (type == 'present') {
                  return _buildCircle(day, Colors.green.withOpacity(0.3));
                } else if (type == 'late') {
                  return _buildCircle(day, Colors.blue.shade200);
                } else if (type == 'absent') {
                  return _buildCircle(day, Colors.red);
                } else if (type == 'leave') {
                  return _buildCircle(day, Colors.orange);
                }

                return Center(child: Text('${day.day}'));
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCircle(DateTime day, Color color) {
    return Center(
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Text(
          '${day.day}',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceCalendar extends StatelessWidget {
  const AttendanceCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime focusedDay = DateTime.utc(2025, 6, 18);

    final eventDays = {
      DateTime.utc(2025, 6, 9): 'present',
      DateTime.utc(2025, 6, 10): 'present',
      DateTime.utc(2025, 6, 16): 'present',
      DateTime.utc(2025, 6, 17): 'present',
      DateTime.utc(2025, 6, 6): 'late',
      DateTime.utc(2025, 6, 24): 'absent',
      DateTime.utc(2025, 6, 25): 'leave',
      DateTime.utc(2025, 6, 18): 'dot',
    };

    return TableCalendar(
      firstDay: DateTime.utc(2025, 6, 1),
      lastDay: DateTime.utc(2025, 6, 30),
      focusedDay: focusedDay,
      calendarFormat: CalendarFormat.month,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
        rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekendStyle: TextStyle(color: Colors.red),
        weekdayStyle: TextStyle(color: Colors.blue),
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          final type = eventDays[DateTime.utc(day.year, day.month, day.day)];
          if (type == 'present') {
            return _buildCircle(day, Colors.green.withOpacity(0.3));
          } else if (type == 'late') {
            return _buildCircle(day, Colors.blue.shade200);
          } else if (type == 'absent') {
            return _buildCircle(day, Colors.red);
          } else if (type == 'leave') {
            return _buildCircle(day, Colors.orange);
          } 
          else if (type == 'dot') 
          {
            return Stack(
              alignment: Alignment.center,
              children: [
                Text('${day.day}'),
                Positioned(
                  bottom: 4,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            );
          }
          return null;
        },
      ),
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

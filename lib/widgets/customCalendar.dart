// lib/widgets/custom_calendar.dart

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatelessWidget {
  final DateTime focusedMonth;
  final DateTime firstDay;
  final DateTime lastDay;
  final Map<DateTime, String> eventDays;
  final Map<String, Color> statusColors;
  final String headerTitle;

  const CustomCalendar({
    super.key,
    required this.focusedMonth,
    required this.firstDay,
    required this.lastDay,
    required this.eventDays,
    required this.statusColors,
    required this.headerTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Static header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              headerTitle,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            firstDay: firstDay,
            lastDay: lastDay,
            focusedDay: focusedMonth,
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            headerVisible: false,
            availableGestures: AvailableGestures.none,
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekendStyle: TextStyle(color: Colors.red),
              weekdayStyle: TextStyle(color: Colors.blue),
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, _) {
                if (day.month != focusedMonth.month) return const SizedBox.shrink();

                final status = eventDays[DateTime.utc(day.year, day.month, day.day)];
                final color = statusColors[status];

                if (color != null) {
                  return _buildCircle(day, color);
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

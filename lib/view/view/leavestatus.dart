import 'package:flutter/material.dart';
import 'package:loginscreen/constants/app_colors.dart';
import 'package:loginscreen/view/view/homescreen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fl_chart/fl_chart.dart';

class Leavestatus extends StatelessWidget {
  Leavestatus({super.key});

  final DateTime _focusedDay = DateTime.utc(2025, 6, 15);

  final Map<DateTime, String> eventDays = {
    DateTime.utc(2025, 6, 3): 'approved',
    DateTime.utc(2025, 6, 12): 'approved',
    DateTime.utc(2025, 6, 16): 'rejected',
    DateTime.utc(2025, 6, 17): 'rejected',
    DateTime.utc(2025, 6, 20): 'pending',
    DateTime.utc(2025, 6, 25): 'approved',
  };

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(context),
                  _buildLeaveCards(),
                  _buildCalendar(),
                  _buildLeaveTable(),
                  _buildLeaveOverview(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: _buildBottomNavBar(),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => HomeScreen()),
              );
            },
            child: Image.asset('asset/ziya academy logo.jpg', height: 5.h),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.symmetric(vertical: 0.5.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(width: 2.w),
          Icon(Icons.notifications, size: 24.sp),
          SizedBox(width: 2.w),
          CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage('asset/profile.jpeg'),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaveCards() {
    final List<Map<String, dynamic>> cards = [
      {
        "title": "Leave Taken",
        "value": "16 days",
        "subtitle": "10 days remaining this month",
        "icon": Icons.calendar_today,
      },
      {
        "title": "Leave Balance",
        "value": "8 days",
        "subtitle": "29 days remaining this month",
        "icon": Icons.calendar_month,
      },
      {
        "title": "Pending Request",
        "value": "1 request",
        "subtitle": "29 days remaining this month",
        "icon": Icons.hourglass_empty,
      },
      {
        "title": "Approved Leaves",
        "value": "5 leaves",
        "subtitle": "29 days remaining this month",
        "icon": Icons.check_circle_outline,
      },
      {
        "title": "Rejected Leaves",
        "value": "2 leaves",
        "subtitle": "29 days remaining this month",
        "icon": Icons.cancel_outlined,
      },
      {
        "title": "Upcoming Leaves",
        "value": "1 leave",
        "subtitle": "Scheduled (25 June)",
        "icon": Icons.event_available,
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Wrap(
        spacing: 4.w,
        runSpacing: 2.h,
        children:
            cards.map((item) {
              return Container(
                width: 43.w,
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(1),
                  boxShadow: [BoxShadow(color: AppColors.grey, blurRadius: 1)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item["title"],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        Icon(item["icon"], color: AppColors.blue),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      item["value"],
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      item["subtitle"],
                      style: TextStyle(fontSize: 14.sp, color: AppColors.grey),
                    ),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildCalendar() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          margin: const EdgeInsets.only(bottom: 10),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "June 2025",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          width: 355,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.grey,
                blurRadius: 4,
                offset: Offset(0, 2),
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
            availableGestures: AvailableGestures.none,
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekendStyle: TextStyle(color: AppColors.red),
              weekdayStyle: TextStyle(color: AppColors.black),
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, _) {
                if (day.month != 6) return const SizedBox.shrink();
                final type =
                    eventDays[DateTime.utc(day.year, day.month, day.day)];
                if (type == 'approved')
                  return _buildSquare(day, AppColors.green);
                if (type == 'rejected') return _buildSquare(day, AppColors.red);
                if (type == 'pending')
                  return _buildSquare(day, AppColors.orange);
                if (type == 'upcoming')
                  return _buildSquare(day, AppColors.blue);
                return Center(child: Text('${day.day}'));
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSquare(DateTime day, Color color) {
    return Center(
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: color.withOpacity(0.7),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(2),
        ),
        alignment: Alignment.center,
        child: Text(
          '${day.day}',
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildLeaveTable() {
    return Padding(
      padding: EdgeInsets.all(3.w),
      child: Table(
        border: TableBorder.all(color: AppColors.grey),
        columnWidths: {
          0: FlexColumnWidth(1.5),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(2),
          3: FlexColumnWidth(3),
        },
        children: [
          _buildTableRow([
            'Date',
            'Leave Type',
            'Status',
            'Reason',
          ], isHeader: true),
          _buildTableRow(['10 June', 'Sick Leave', 'Approved', 'Fever']),
          _buildTableRow([
            '20 June',
            'Casual Leave',
            'Pending',
            'Family Function',
          ]),
          _buildTableRow(['01 July', 'WFH', 'Rejected', 'No backup']),
        ],
      ),
    );
  }

  TableRow _buildTableRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
      decoration: BoxDecoration(color: isHeader ? AppColors.white : null),
      children:
          cells.map((cell) {
            Color? textColor;
            if (cell == 'Approved') textColor = AppColors.green;
            if (cell == 'Pending') textColor = AppColors.orange;
            if (cell == 'Rejected') textColor = AppColors.red;
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                cell,
                style: TextStyle(
                  color: isHeader ? AppColors.lightblue : textColor,
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildLeaveOverview() {
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(thickness: 1),
          const SizedBox(height: 4),
          const Text(
            "Leave Overview",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            "Your leave distribution for the current year",
            style: TextStyle(color: AppColors.grey),
          ),
          const SizedBox(height: 8),
          SizedBox(height: 2.h),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 20,
                barTouchData: BarTouchData(enabled: false),
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(),
                  topTitles: AxisTitles(),
                  rightTitles: AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        const titles = ['Q1', 'Q2', 'Q3', 'Q4'];
                        return Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            titles[value.toInt()],
                            style: const TextStyle(fontSize: 14),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  _makeBarData(0, 6),
                  _makeBarData(1, 4),
                  _makeBarData(2, 3),
                  _makeBarData(3, 2),
                ],
              ),
            ),
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 8),
                const Text('Leave days taken', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Divider(thickness: 1),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Total days"), Text("Remaining")],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("20"), Text("29")],
          ),
          const Divider(thickness: 1),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  BarChartGroupData _makeBarData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: AppColors.blue,
          width: 70,
          borderRadius: BorderRadius.circular(2),
        ),
      ],
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: AppColors.lightblue,
      unselectedItemColor: AppColors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_forward),
          label: 'Leave',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}

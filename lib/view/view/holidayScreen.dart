import 'package:flutter/material.dart';
import 'package:loginscreen/constants/app_colors.dart';
import 'package:loginscreen/view/view/homescreen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class HolidayScreen extends StatefulWidget {
  @override
  State<HolidayScreen> createState() => _HolidayScreenState();
}

class _HolidayScreenState extends State<HolidayScreen> {
  final TextEditingController _searchController = TextEditingController();
  DateTime _focusedDay = DateTime(2025, 6, 15);
  DateTime? _selectedDay;
  int _currentIndex = 0;

  final List<Map<String, dynamic>> holidays = [
    {'date': '2025-06-03', 'color': Colors.green},
    {'date': '2025-06-12', 'color': Colors.green},
    {'date': '2025-06-16', 'color': Colors.blue},
    {'date': '2025-06-17', 'color': Colors.blue},
    {'date': '2025-06-20', 'color': Colors.yellow},
    {'date': '2025-06-25', 'color': Colors.blue},
  ];

  Color? getColorForDate(DateTime day) {
    final formatted = DateFormat('yyyy-MM-dd').format(day);
    final match = holidays.firstWhere(
      (element) => element['date'] == formatted,
      orElse: () => {},
    );
    return match['color'];
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderWithSearch(),
                    SizedBox(height: 2.h),
                    _buildTopSummaryCards(),
                    SizedBox(height: 2.h),
                    _buildLegend(),
                    SizedBox(height: 1.h),
                    _buildBoxedCalendar(),
                    SizedBox(height: 3.h),
                    _buildHolidayTable(),
                    SizedBox(height: 6),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            selectedItemColor: const Color(0xFF008CFF),
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                if (index == 0) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                }
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.exit_to_app_sharp),
                label: 'Leave',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeaderWithSearch() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            },
            child: Image.asset('asset/ziya academy logo.jpg', height: 5.h),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 2.w),
          Icon(Icons.notifications_none, size: 22.sp),
          SizedBox(width: 2.w),
          CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage('asset/profile.jpeg'),
          ),
        ],
      ),
    );
  }

  Widget _buildTopSummaryCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _infoCard(
          icon: Icons.calendar_month,
          title: "Total Holidays",
          value: "18 days",
          subtitle: "in a year",
          bottomBar: LinearProgressIndicator(
            value: 0.7,
            color: AppColors.lightblue,
            backgroundColor: Colors.blue.shade100,
          ),
        ),
        _infoCard(
          icon: Icons.event_note,
          title: "Upcoming Holidays",
          value: "4",
          subtitle: "17 June",
          bottomText: "Remaining this month",
        ),
      ],
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    Widget? bottomBar,
    String? bottomText,
  }) {
    return Container(
      width: 46.w,
      height: 40.w,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Icon(icon, color: AppColors.lightblue, size: 20.sp),
          ),
          SizedBox(height: 1.h),
          Text(title, style: TextStyle(fontSize: 16.sp)),
          SizedBox(height: 0.5.h),
          Text(
            value,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          Text(subtitle, style: TextStyle(fontSize: 13.sp, color: Colors.grey)),
          if (bottomBar != null) ...[SizedBox(height: 1.h), bottomBar],
          if (bottomText != null) ...[
            SizedBox(height: 0.5.h),
            Text(
              bottomText,
              style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      children: const [
        Legend(color: Colors.green, label: 'Public'),
        Legend(color: Colors.yellow, label: 'Optional'),
        Legend(color: Colors.blue, label: 'Company'),
      ],
    );
  }

  Widget _buildBoxedCalendar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(2.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.h, left: 2.w, bottom: 1.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'June 2025',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          TableCalendar(
            firstDay: DateTime.utc(2025, 6, 1),
            lastDay: DateTime.utc(2025, 6, 30),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selected, focused) {
              setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              });
            },
            headerVisible: false,
            availableGestures: AvailableGestures.none,
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: Colors.blue),
              weekendStyle: TextStyle(color: Colors.blue),
            ),
            calendarBuilders: CalendarBuilders(
              dowBuilder: (context, day) {
                final text = DateFormat.E().format(day);
                Color textColor =
                    day.weekday == DateTime.sunday
                        ? Colors.red
                        : day.weekday == DateTime.saturday
                        ? Colors.black
                        : Colors.blue;
                return Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
              defaultBuilder: (context, day, _) {
                if (day.month != 6) return const SizedBox.shrink();
                final color = getColorForDate(day);
                return Center(
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${day.day}',
                      style: TextStyle(
                        color:
                            day.weekday == DateTime.sunday
                                ? Colors.red
                                : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHolidayTable() {
    List<String> dates = ["17 June", "15 August", "23 October"];
    List<List<String>> data = [
      ["Day", "Tuesday", "Thursday", "Wednesday"],
      ["Holiday Name", "Bakrid", "Independence Day", "Diwali"],
      ["Type", "Public\nHoliday", "National Holiday", "Optional"],
      ["Note", "Company-wide holiday", "Paid Leave", "Can be applied"],
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Table(
        border: TableBorder.all(color: Colors.grey.shade300, width: 1),
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(1.2),
          2: FlexColumnWidth(1.2),
          3: FlexColumnWidth(1.2),
        },
        children: [
          TableRow(
            children: [
              _tableCell("Date", isHeader: true),
              ...dates.map((date) => _tableCell(date)).toList(),
            ],
          ),
          ...data.map(
            (row) => TableRow(
              children:
                  row
                      .mapIndexed(
                        (i, cell) => _tableCell(cell, isHeader: i == 0),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableCell(String text, {bool isHeader = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.5.h),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: isHeader ? 16.sp : 15.sp,
          color:
              isHeader
                  ? const Color.fromARGB(255, 117, 179, 241)
                  : Colors.black,
        ),
      ),
    );
  }
}

class Legend extends StatelessWidget {
  final Color color;
  final String label;
  const Legend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        SizedBox(width: 1.w),
        Text(label),
        SizedBox(width: 3.w),
      ],
    );
  }
}

extension MapIndexed<E> on List<E> {
  Iterable<T> mapIndexed<T>(T Function(int index, E item) f) {
    var index = 0;
    return map((e) => f(index++, e));
  }
}

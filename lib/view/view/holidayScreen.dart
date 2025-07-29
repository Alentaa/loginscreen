import 'package:flutter/material.dart';
import 'package:loginscreen/constants/app_colors.dart';
import 'package:loginscreen/view/view/homescreen.dart';
import 'package:loginscreen/view/view/notification.dart';
import 'package:loginscreen/view/view/profilescreen.dart';
import 'package:loginscreen/widgets/customCalendar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';

class HolidayScreen extends StatefulWidget {
  const HolidayScreen({super.key});

  @override
  State<HolidayScreen> createState() => _HolidayScreenState();
}

class _HolidayScreenState extends State<HolidayScreen> {
  final TextEditingController _searchController = TextEditingController();
  DateTime _focusedDay = DateTime(2025, 6, 15);
  int _currentIndex = 0;

  final Map<DateTime, String> eventDays = {
    DateTime.utc(2025, 6, 3): 'public',
    DateTime.utc(2025, 6, 12): 'public',
    DateTime.utc(2025, 6, 16): 'company',
    DateTime.utc(2025, 6, 17): 'company',
    DateTime.utc(2025, 6, 20): 'optional',
    DateTime.utc(2025, 6, 25): 'company',
  };

  final Map<String, Color> statusColors = {
    'public': Colors.green,
    'optional': Colors.yellow,
    'company': Colors.blue,
  };

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
                    CustomCalendar(
                      focusedMonth: _focusedDay,
                      firstDay: DateTime.utc(2025, 6, 1),
                      lastDay: DateTime.utc(2025, 6, 30),
                      eventDays: eventDays,
                      statusColors: statusColors,
                      headerTitle: 'June 2025',
                    ),
                    SizedBox(height: 3.h),
                    _buildHolidayTable(),
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
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
            child: const Icon(Icons.notifications_none, color: Colors.blue),
          ),

          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            child: const CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('asset/profile.jpeg'),
            ),
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
            offset: const Offset(0, 2),
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
            offset: const Offset(0, 2),
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
          color: isHeader ? AppColors.lightblue : Colors.black,
        ),
      ),
    );
  }
}

class Legend extends StatelessWidget {
  final Color color;
  final String label;
  const Legend({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, shape: BoxShape.rectangle),
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

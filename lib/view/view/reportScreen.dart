import 'package:flutter/material.dart';
import 'package:loginscreen/view/view/notification.dart';
import 'package:loginscreen/view/view/profilescreen.dart';
import 'package:loginscreen/viewmodel/reportsviewmodel.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReportsViewModel(),
      child: const _ReportsScreenBody(),
    );
  }
}

class _ReportsScreenBody extends StatelessWidget {
  const _ReportsScreenBody();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ReportsViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_chart),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Leave',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                SizedBox(height: 2.h),
                const Text(
                  "Reports",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 2.h),
                _buildCards(),
                SizedBox(height: 2.h),
                const Text(
                  "Daily Clock-In/Out Log",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                SizedBox(height: 2.h),
                _buildAttendanceTable(vm),
                SizedBox(height: 3.h),
                const Text(
                  "Attendance",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                SizedBox(height: 2.5.h),
                SizedBox(height: 3.h),
                _buildLegend(),
                SizedBox(height: 2.5.h),
                _buildLineGraph(vm),
                SizedBox(height: 5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/home'),
          child: Image.asset("asset/ziya academy logo.jpg", height: 5.h),
        ),
        Container(
          width: 50.w,
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.white),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            children: [
              Icon(Icons.search, size: 18),
              SizedBox(width: 6),
              Expanded(
                child: TextField(
                  decoration: InputDecoration.collapsed(hintText: "Search"),
                ),
              ),
            ],
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
    );
  }

  Widget _buildCards() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.2, // Taller cards
      padding: EdgeInsets.zero,
      children: [
        _infoCard(
          "Total Working Days (This Month)",
          "22 days",
          Icons.calendar_today,
        ),
        _infoCard("Total Hours Worked", "145 hrs", Icons.timer),
        _infoCard(
          "Tasks Completed",
          "35 this month",
          Icons.check_circle_outline,
        ),
        _infoCard("Average Daily Hours", "6.6 hrs/day", Icons.alarm),
      ],
    );
  }

  Widget _infoCard(String title, String value, IconData icon) {
    return Container(
      margin: EdgeInsets.all(1.w),
      padding: EdgeInsets.all(2.w), // More inner spacing
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Icon(icon, color: Colors.blue, size: 22.sp),
          ),
          SizedBox(height: 1.h),
          Text(title, style: TextStyle(fontSize: 15.sp, color: Colors.grey)),
          SizedBox(height: 0.7.h),
          Text(
            value,
            style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceTable(ReportsViewModel vm) {
    return Table(
      border: TableBorder.all(color: AppColors.grey),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(2.5),
        2: FlexColumnWidth(2.5),
        3: FlexColumnWidth(2),
        4: FlexColumnWidth(2),
      },
      children: [
        _buildTableRow([
          "Date",
          "Check-in",
          "Check-out",
          "Total Hrs",
          "Status",
        ], isHeader: true),
        ...vm.attendanceRecords
            .map(
              (record) => _buildTableRow([
                record.date,
                record.checkIn ?? "--",
                record.checkOut ?? "--",
                record.totalHours,
                record.status,
              ], status: record.status),
            )
            .toList(),
      ],
    );
  }

  TableRow _buildTableRow(
    List<String> cells, {
    bool isHeader = false,
    String? status,
  }) {
    return TableRow(
      children:
          cells.asMap().entries.map((entry) {
            int index = entry.key;
            String cell = entry.value;

            Color textColor = Colors.black;

            if (!isHeader && index == 4 && status != null) {
              if (status == "Present") {
                textColor = Colors.green;
              } else if (status == "Absent") {
                textColor = Colors.red;
              } else if (status == "Half Day") {
                textColor = Colors.orange;
              }
            }

            return Padding(
              padding: EdgeInsets.all(1.h),
              child: Text(
                cell,
                style: TextStyle(
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                  fontSize: 15.sp,
                  color: textColor,
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildLegend() {
    return Row(
      children: const [
        _Legend(color: Colors.green, label: "Present"),
        SizedBox(width: 19),
        _Legend(color: Colors.red, label: "Absence"),
        SizedBox(width: 19),
        _Legend(color: Colors.blue, label: "Avg hrs"),
      ],
    );
  }

  Widget _buildLineGraph(ReportsViewModel vm) {
    return SizedBox(
      height: 220,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine:
                (value) => FlLine(color: Colors.grey[300], dashArray: [4]),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 34,
                getTitlesWidget: (value, _) {
                  final months = [
                    "Jan",
                    "Feb",
                    "Mar",
                    "Apr",
                    "May",
                    "Jun",
                    "Jul",
                    "Aug",
                    "Sep",
                    "Oct",
                    "Nov",
                    "Dec",
                  ];
                  return Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      months[value.toInt() % 12],
                      style: TextStyle(fontSize: 10),
                    ),
                  );
                },
                interval: 1,
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: 11,
          lineBarsData: [
            LineChartBarData(
              isCurved: false,
              color: Colors.green,
              barWidth: 2,
              dotData: FlDotData(show: true),
              spots: vm.presentSpots,
            ),
            LineChartBarData(
              isCurved: false,
              color: Colors.red,
              barWidth: 2,
              dotData: FlDotData(show: true),
              spots: vm.absentSpots,
            ),
            LineChartBarData(
              isCurved: false,
              color: Colors.blue,
              barWidth: 2,
              dotData: FlDotData(show: true),
              spots: vm.avgHourSpots,
            ),
          ],
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;
  const _Legend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(color: color, shape: BoxShape.rectangle),
        ),
        SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 16.sp)),
      ],
    );
  }
}

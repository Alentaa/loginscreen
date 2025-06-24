import 'package:flutter/material.dart';
import 'package:loginscreen/view/view/leave_dashboard.dart';
import 'package:loginscreen/view/view/leavespage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LeaveScreen extends StatefulWidget {
  const LeaveScreen({super.key});

  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  bool isDashboardSelected = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(width),
            SizedBox(height: height * 0.015),
            _buildTabBar(width),
            SizedBox(height: height * 0.02),
            Expanded(
              child:
                  isDashboardSelected
                      ? const LeaveDashboardScreen() 
                      : const LeavesPage(),
            ),
          ],
        ),
      ),
    );
  }

 
  Widget _buildHeader(double width) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: width * 0.025,
      ),
      child: Row(
        children: [
          Image.asset(
            'asset/ziya academy logo.jpg',
            width: width * 0.1,
            height: width * 0.1,
            fit: BoxFit.cover,
          ),
          SizedBox(width: width * 0.03),
          Expanded(
            child: Container(
              height: width * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Row(
                children: [
                  Icon(Icons.search, size: width * 0.045, color: Colors.grey),
                  SizedBox(width: width * 0.02),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: InputBorder.none,
                        isCollapsed: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: width * 0.03),
          Stack(
            children: [
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.blue,
                  size: width * 0.07,
                ),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: CircleAvatar(
                  radius: width * 0.012,
                  backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
          SizedBox(width: width * 0.02),
          CircleAvatar(
            radius: width * 0.045,
            backgroundImage: const AssetImage('asset/profile.jpeg'),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _tabItem(
          'Dashboard',
          isDashboardSelected,
          Icons.dashboard_customize_outlined,
          width,
        ),
        _tabItem('Request Leave', !isDashboardSelected, Icons.logout, width),
      ],
    );
  }

  Widget _tabItem(String label, bool isSelected, IconData icon, double width) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDashboardSelected = (label == 'Dashboard');
        });
      },
      child: Column(
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.blue : Colors.grey,
            size: width * 0.065,
          ),
          SizedBox(height: width * 0.01),
          Text(
            label,
            style: TextStyle(
              fontSize: width * 0.035,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.blue : Colors.grey,
            ),
          ),
          SizedBox(height: width * 0.01),
          if (isSelected)
            Container(
              height: width * 0.01,
              width: width * 0.12,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(0),
              ),
            ),
        ],
      ),
    );
  }
}

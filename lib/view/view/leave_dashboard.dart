import 'package:flutter/material.dart';
import 'package:loginscreen/constants/app_colors.dart';
import 'package:loginscreen/view/view/notification.dart';
import 'package:loginscreen/view/view/profilescreen.dart';
import 'package:loginscreen/viewmodel/leavedashboard.dart';
import 'package:loginscreen/widgets/leavebar.dart';
import 'package:loginscreen/widgets/leavecard.dart';
import 'package:provider/provider.dart';

import '../view/leavespage.dart';
import '../view/homescreen.dart';

class LeaveDashboardScreen extends StatelessWidget {
  const LeaveDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LeaveDashboardViewModel(),
      child: Consumer<LeaveDashboardViewModel>(
        builder:
            (context, viewModel, _) => Scaffold(
              backgroundColor: AppColors.white,
              body: SafeArea(
                child: Column(
                  children: [
                    _buildHeader(context, viewModel),
                    const SizedBox(height: 10),
                    _buildTabBar(viewModel),
                    const SizedBox(height: 10),
                    Expanded(
                      child:
                          viewModel.selectedTabIndex == 0
                              ? _buildDashboardContent(viewModel)
                              : const LeavesPage(),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, LeaveDashboardViewModel vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap:
                () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                ),
            child: Image.asset('asset/ziya academy logo.jpg', height: 50),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                TextField(
                  controller: vm.searchController,
                  onChanged: vm.onSearchChanged,
                  onTap: () => vm.showSuggestions = true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search',
                    filled: true,
                    fillColor: AppColors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                if (vm.showSuggestions)
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(maxHeight: 150),
                    child: ListView(
                      shrinkWrap: true,
                      children:
                          vm.allSuggestions
                              .where(
                                (item) => item.toLowerCase().contains(
                                  vm.searchController.text.toLowerCase(),
                                ),
                              )
                              .map(
                                (s) => ListTile(
                                  title: Text(s),
                                  onTap: () => vm.onSuggestionTap(s),
                                ),
                              )
                              .toList(),
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
      ),
    );
  }

  Widget _buildTabBar(LeaveDashboardViewModel vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _tabButton('Dashboard', 0, Icons.dashboard_customize_outlined, vm),
          _tabButton('Request Leave', 1, Icons.request_page_outlined, vm),
        ],
      ),
    );
  }

  Widget _tabButton(
    String title,
    int index,
    IconData icon,
    LeaveDashboardViewModel vm,
  ) {
    final isSelected = vm.selectedTabIndex == index;
    return GestureDetector(
      onTap: () => vm.changeTab(index),
      child: Row(
        children: [
          Icon(icon, color: isSelected ? Colors.blue : Colors.black54),
          const SizedBox(width: 6),
          Text(
            title,
            style: TextStyle(color: isSelected ? Colors.blue : Colors.black54),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(left: 6),
              height: 3,
              width: 24,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDashboardContent(LeaveDashboardViewModel vm) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children:
              vm.leaveCards
                  .take(2)
                  .map(
                    (card) => LeaveCard(
                      title: card.title,
                      value: card.value,
                      subtitle: card.subtitle,
                      icon: card.icon,
                    ),
                  )
                  .toList(),
        ),
        const SizedBox(height: 10),
        Row(
          children:
              vm.leaveCards
                  .skip(2)
                  .map(
                    (card) => LeaveCard(
                      title: card.title,
                      value: card.value,
                      subtitle: card.subtitle,
                      icon: card.icon,
                    ),
                  )
                  .toList(),
        ),
        const SizedBox(height: 24),
        const Text(
          "Leave Overview",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text(
          "Your leave distribution for the current year",
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 8),
        const SizedBox(height: 150, child: LeaveBarChart()),
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
        const Divider(thickness: 1),
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
        const Text(
          "Upcoming Leave",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text(
          "Your scheduled time off",
          style: TextStyle(color: Colors.black87),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("April 22, 2025 to Apr 24, 2025 (3 days)"),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text("Pending", style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

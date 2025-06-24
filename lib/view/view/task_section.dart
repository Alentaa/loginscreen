import 'package:flutter/material.dart';
import 'package:loginscreen/view/view/mytasks.dart';
import 'package:loginscreen/view/view/ongoing.dart';
import 'package:loginscreen/view/view/sortfilter.dart';
import 'package:loginscreen/view/view/taskbar.dart';
import 'package:loginscreen/view/view/tasktracker.dart';
import 'package:loginscreen/view/view/worksummary.dart';

class TaskSection extends StatefulWidget {
  const TaskSection({super.key});

  @override
  State<TaskSection> createState() => _TaskSectionState();
}

class _TaskSectionState extends State<TaskSection> {
  int selectedTabIndex = 0;
  int selectedSortIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         

          const SizedBox(height: 12),

          TaskTabBar(
            selectedIndex: selectedTabIndex,
            onTabSelected: (index) {
              setState(() {
                selectedTabIndex = index;
              });
            },
          ),

          const SizedBox(height: 12),

          
          SortFilterBar(
            selectedSortIndex: selectedSortIndex,
            onSortSelected: (index) {
              setState(() {
                selectedSortIndex = index;
              });
            },
          ),

          const SizedBox(height: 12),

          // Tab Content
          SizedBox(
            height: 300, 
            child: IndexedStack(
              index: selectedTabIndex,
              children: const [
                TaskMyTab(),
                TaskTrackerTab(),
                OngoingPendingTab(),
                WorkSummaryTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
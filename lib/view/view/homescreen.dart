import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginscreen/view/view/bottombar.dart';
import 'package:loginscreen/view/view/checkin.dart';
import 'package:loginscreen/view/view/dashboardgird.dart';
import 'package:loginscreen/view/view/header.dart';
import 'package:loginscreen/view/view/overview.dart';
import 'package:loginscreen/view/view/task_section.dart';
import 'package:provider/provider.dart';
import 'package:loginscreen/viewmodel/checkinprovider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserNameFromFirestore();
  }

  Future<void> _loadUserNameFromFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

      if (doc.exists && doc.data() != null) {
        setState(() {
          userName = doc['name'] ?? '';
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderWidget(),
              const SizedBox(height: 10),

              Text(
                "Good Morning,\n$userName",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),

              const SizedBox(height: 12),
              const Checkin(),
              const SizedBox(height: 24),

              const Text(
                'Overview',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 5),
              const OverviewRow(),
              const SizedBox(height: 24),

              Consumer<CheckinProvider>(
                builder: (context, checkinProvider, _) {
                  if (!checkinProvider.isPunchedIn) {
                    return const SizedBox.shrink();
                  }
                  return const TaskSection();
                },
              ),

              const SizedBox(height: 24),

              const Text(
                'Dashboard',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              const DashboardGrid(),
            ],
          ),
        ),
      ),
    );
  }
}

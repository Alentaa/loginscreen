import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginscreen/constants/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String userName = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
      if (doc.exists) {
        setState(() {
          userName = doc['name'] ?? 'User';
          isLoading = false;
        });
      } else {
        setState(() {
          userName = 'User';
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 78.w,
          child: Stack(
            children: [
              Container(
                width: 74.w,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 12, 58, 123),
                      Color.fromARGB(255, 7, 79, 10),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(5.w),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 1.5.h),
                child: Row(
                  children: [
                    Container(
                      height: 6.h,
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1),
                        child: Image.asset(
                          'asset/profile.jpeg',
                          width: 55,
                          height: 48,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isLoading ? 'Hemant Rangarajan' : userName,
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          "Full-stack Developer",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 2.h,
                right: 1.w,
                child: const CircleAvatar(
                  backgroundImage: AssetImage('asset/ziya academy logo.jpg'),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 2.w),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: AppColors.black, blurRadius: 1.w)],
          ),
          padding: EdgeInsets.all(1.5.w),
          child: Icon(Icons.notifications_sharp, color: AppColors.blue, size: 6.w),
        ),
      ],
    );
  }
}

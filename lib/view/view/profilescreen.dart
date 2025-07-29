import 'package:flutter/material.dart';
import 'package:loginscreen/constants/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.exit_to_app), label: 'Leave'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // Background Banner
                  Container(
                    height: 26.h,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("asset/laptop photo.jpeg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Name & Title inside the photo
                  Positioned(
                    bottom: 2.h,
                    left: 30.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Alenta",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(height: 0.3.h),
                        Text(
                          "Full-stack Developer",
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Profile Picture (half overlapping)
                  Positioned(
                    bottom: -40, // Overlapping from bottom of image
                    left: MediaQuery.of(context).size.width / 2 - 180,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage("asset/profile.jpeg"),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 5.5.h),

              // Info Card
              Container(
                margin: EdgeInsets.symmetric(horizontal: 6.w),
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _profileRow("Name", "Alenta "),
                    Divider(color: Colors.grey.shade300),
                    _profileRow("Employee ID", "EMP00123"),
                    Divider(color: Colors.grey.shade300),
                    _profileRow("Designation", "Full-stack Developer"),
                    Divider(color: Colors.grey.shade300),
                    _profileRow("Department", "Software Development Team"),
                  ],
                ),
              ),

              SizedBox(height: 5.h),

              Image.asset(
                "asset/working_image-removebg-preview.png",
                height: 25.h,
              ),

              SizedBox(height: 2.h),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightblue,
                  minimumSize: Size(60.w, 6.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {},
                child: const Text("Start work"),
              ),

              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$title :",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

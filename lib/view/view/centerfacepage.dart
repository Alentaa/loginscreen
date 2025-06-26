import 'package:flutter/material.dart';
import 'package:loginscreen/constants/app_colors.dart';
import 'package:loginscreen/view/view/punch_access.dart';

class CenterYourFacePage extends StatefulWidget {
  final bool isPunchIn;

  const CenterYourFacePage({super.key, required this.isPunchIn});

  @override
  State<CenterYourFacePage> createState() => _CenterYourFacePageState();
}

class _CenterYourFacePageState extends State<CenterYourFacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color(0xFFB3E5FC),
              Color(0xFF81D4FA), 
            ],
          ),
        ),
        child: Column(
          children: [
            const Spacer(flex: 3),

            /// Top Text Section
            Column(
              children: const [
                Text(
                  "Capture Your Photo",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "point your face right at the box,\nthen take a photo",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),

            const Spacer(flex: 2),

           
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Color(0xFFB3E5FC)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 24,
                    child: const Icon(
                      Icons.photo_camera_outlined,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(width: 30),

                  
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) =>
                                  PunchSuccessPage(isPunchIn: widget.isPunchIn),
                        ),
                      );
                    },
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.lightblue,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.check,
                        color: AppColors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),

                 
                  CircleAvatar(
                    backgroundColor: AppColors.white,
                    radius: 24,
                    child: const Icon(Icons.flash_on, color: AppColors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

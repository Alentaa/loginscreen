import 'package:flutter/material.dart';
import 'package:loginscreen/model/faceverification_model.dart';
import 'centerfacepage.dart';

class FaceVerificationPage extends StatefulWidget {
  final FaceVerificationModel model;

  const FaceVerificationPage({super.key, required this.model, required bool isPunchIn});

  @override
  State<FaceVerificationPage> createState() => _FaceVerificationPageState();
}

class _FaceVerificationPageState extends State<FaceVerificationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final double frameHeight = 120;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: 0, end: frameHeight - 2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Face Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Please capture your face",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),

              Stack(
                children: [
                  Container(
                    width: width * 0.3,
                    height: frameHeight,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 92, 160, 224),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(Icons.person_outline, size: 60),
                    ),
                  ),

                
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Positioned(
                        top: _animation.value,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 2,
                          color: Colors.blueAccent.withOpacity(0.8),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 50),

              SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CenterYourFacePage(
                          isPunchIn: widget.model.isPunchIn,
                        ),
                      ),
                    );
                  },
                  child: const Text("Take Photo", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
